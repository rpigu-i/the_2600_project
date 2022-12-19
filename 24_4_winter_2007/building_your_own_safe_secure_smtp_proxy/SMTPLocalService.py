import sys, smtps, string, smtplib, rfc822, StringIO,time,pexpect,os
# This extends the smtps.SMTPServerInterface and specializes it to
# proxy requests onwards. 
class SMTPLocalService(smtps.SMTPServerInterface):
    def __init__(self):
        self.user="MY_USERNAME"
        self.password='MY_PASSWORD'
        self.scpServer="host.domain.tld"
        self.scpServerPath="/path/to/your/message_directory/"
        self.savedTo = []
        self.savedMailFrom = ''
        self.shutdown = 0
        
    def mailFrom(self, args):
        # Stash who its from for later
        self.savedMailFrom = smtps.stripAddress(args)
        
    def rcptTo(self, args):
        # Stashes multiple RCPT TO: addresses
        self.savedTo.append(args)
        
    def data(self, args):
        # write the mail to a file in /tmp
        # and then scp the file.
        # After scp-ing the file delete it from /tmp
        timeStamp=time.strftime("%m%d%y_%I%M%S%p",time.localtime())#just name the message files
        														   #with the current time
        data=self.frobData(args)
        filename=timeStamp
        localFilePath="/tmp/"
        filename_new=filename+".new"
        filename_msg=filename+".msg"
        file=open(localFilePath+filename_new,"w")
        file.writelines(self.savedTo)
        file.write("FROM:<"+self.savedMailFrom+">\n")
        file.write(data)
        file.close()
        #We do not want incomplete messages to be process on the server
        #to avoid this we first send the message with a .new extension
        #after transfer is complete the message is renamed with a .msg extension
        #The remote side only processes files ending in .msg        
        cmd=pexpect.spawn('scp -r %s %s@%s:%s' % (localFilePath+filename_new,self.user,self.scpServer,self.scpServerPath))
        cmd.expect('.ssword:*') 
        cmd.sendline(self.password)
        cmd.interact()     
        #here we rename the file
        cmd=pexpect.spawn('ssh %s@%s mv %s %s' % (self.user,self.scpServer,self.scpServerPath+filename_new,self.scpServerPath+filename_msg))
        cmd.expect('.ssword:*')
        cmd.sendline(self.password)
        cmd.interact()
        
        os.remove(localFilePath+filename_new)
        self.savedTo = []
        
    def quit(self, args):
        if self.shutdown:
            print 'Shutdown at user request'
            sys.exit(0)

    def frobData(self, data):
        hend = string.find(data, '\n\r')
        if hend != -1:
            rv = data[:hend]
        else:
            rv = data[:]
        rv = rv + 'X-PySpy: Python SMTP Proxy Frobnication'
        rv = rv + data[hend:]
        return rv

def Usage():
    print """Usage SMTPLocalService.py port
Where:
  port = Client SMTP Port number (ie 25)."""
    sys.exit(1)
    
if __name__ == '__main__':
    if len(sys.argv) != 2:
        Usage()
    port = int(sys.argv[1])
    service = SMTPLocalService()
    server = smtps.SMTPServer(port)
    server.serve(service)

