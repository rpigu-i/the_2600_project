import sys, smtps, string, smtplib, rfc822, StringIO,os,glob,DNS,time
# Designed to run via cron. Will check a directory and
# if any new message files are there it will send them of and
# move them to an archive sub-directory
# It uses DNS to resolve each RCPT TO:
# address, then uses smtplib to forward the client mail on the
# resolved mailhost.
class SMTPRemoteService():
    def __init__(self):
        self.dnshost="199.45.32.41" #Some dns that belongs to verizon. :)
                                    #this should work but if you want to 
                                    #use another one feel free
        self.pollDir="/path/to/your/message_directory/"
        self.archiveDir=self.pollDir+"msg_archive/"
        self.fileList=[]
        self.savedTo = []
        self.savedMailFrom = ''
        
    def mxlookup(self,host):
        global DNSHOST
        a = DNS.DnsRequest(host, qtype = 'mx', server=self.dnshost).req().answers
        l = map(lambda x:x['data'], a)
        l.sort()
        return l
        
    def mailFrom(self, args):
        # Stash who its from for later
        self.savedMailFrom = smtps.stripAddress(args)
        
    def rcptTo(self, args):
        # Stashes multiple RCPT TO: addresses
        self.savedTo.append(args)
        
    def data(self, args):
        # Process client mail data. It inserts a silly X-Header, then
        # does a MX DNS lookup for each TO address stashed by the
        # rcptTo method above. Messages are logged to the console as
        # things proceed. 
        data = self.frobData(args)
        for addressee in self.savedTo:
            toHost, toFull = smtps.splitTo(addressee)
            # Treat this TO address speciallt. All because of a
            # WINSOCK bug!
            if toFull == 'shutdown@shutdown.now':
                self.shutdown = 1
                return
            sys.stdout.write('Resolving ' + toHost + '...')
            resolved = self.mxlookup(toHost)
            if len(resolved):
                sys.stdout.write(' found. Sending ...')
                mxh = resolved[0][1]
                for retries in range(3):
                    try:
                        smtpServer = smtplib.SMTP(mxh)
                        smtpServer.set_debuglevel(0)
                        smtpServer.helo(mxh)
                        smtpServer.sendmail(self.savedMailFrom, toFull, data)
                        smtpServer.quit()
                        print ' Sent TO:', toFull, mxh
                        break
                    except Exception, e:
                        print '*** SMTP FAILED', retries, mxh, sys.exc_info()[1]
                        continue
            else:
                print '*** NO MX HOST for :', toFull
        self.savedTo = []

    def frobData(self, data):
        hend = string.find(data, '\n\r')
        if hend != -1:
            rv = data[:hend]
        else:
            rv = data[:]
        rv = rv + 'X-PySpy: Python SMTP Proxy Frobnication'
        rv = rv + data[hend:]
        return rv
        
    def archiveFile(self,msgfile):
       timeStamp=time.strftime("%m%d%y_%I%M%S%p",time.localtime())
       in_msg=open(msgfile, "rb")
       outfile=open(self.archiveDir+timeStamp, "wb")
       outfile.write(in_msg.read())
       outfile.close()
       in_msg.close()
       os.remove(msgfile)
       
    def run(self):
        contents=""
        inContents=False
        self.fileList=glob.glob(self.pollDir+'*.msg') 
        for filename in self.fileList:
            for line in open(filename,"r").readlines():
                if line.startswith("RCPT"):
                    self.rcptTo(line)
                if line.startswith("FROM:"):
                    self.mailFrom(line[5:])              
                if line.startswith("Message-ID"):
                    inContents=True
                if inContents:
                    contents=contents+line
            self.data(contents)
            inContents=False
            contents=""
            self.archiveFile(filename)
    
    
if __name__ == '__main__':
    service = SMTPRemoteService()
    service.run()

