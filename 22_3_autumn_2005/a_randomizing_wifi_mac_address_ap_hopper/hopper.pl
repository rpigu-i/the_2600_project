#!/usr/bin/perl
#
# an ap hopper using random MAC by eprom.jones@gmail.com
#

use Term::ANSIColor qw(:constants);
use HotKey;

sub doit
    {
     print GREEN, "\n Doin it... \n", RESET;
     print `iwconfig eth0 ap $mac[$use]`;
     print `iwconfig eth0 essid $essid[$use]`;
     print `iwconfig eth0 channel $chan[$use]`;
     sleep (1);
     system (`/sbin/dhcpcd -d -t 10 eth0`);
     print GREEN, "OK...\n", RESET;
    }

sub stopradio
    {
     print RED, "\n quitin' time. \n", RESET;
     system (`/sbin/dhcpcd -k`);
     system (`modprobe -r ipw2200`);
    }

sub startradio
    {
     system (`modprobe ipw2200 mode=0 channel=0 associate=0`);
     print   `ifconfig eth0 hw ether $newMAC`;
    }

$one = "00";      
@twos = ( "aa", "a0", "03", "02", "0e", "04", "12", "13", "11" );
@threes = ( "00", "c9", "47", "b3", "0c", "23", "f0", "02", "11" );
@news;
for ($i=0; $i<6; $i++)
  {	
    $temp = sprintf "%1x", rand(16);
    $news[$i] =$temp; 
  }
$real_combo = rand(9);
$newMAC = sprintf ("%s:%s:%s:%s%s:%s%s:%s%s", $one, $twos[$real_combo], $threes[$real_combo],
                                  $news[0], $news[1], $news[2], $news[3], $news[4], $news[5] );
print "$newMAC\n";

startradio;
system (`iwlist eth0 scan 1>/tmp/froglog.pad 2>/dev/null`);
open(INFILE,  "/tmp/froglog.pad")   or die "Can't hear no damned ribbits.";
while (<INFILE>)
  {
    if (/$\d{2}/)
      {
        s/ //g;
        /^(.*s:)(.*)$/;
        push @mac,$2;
      }
    if (/ESSID/)
      {
        s/ //g;
        /^(.*\")(.*)\"$/;
        push @essid,$2;
      }
    if (/$802\.11.+?/)
      {
        /^(.*802\.11)(.+?)$/;
        push @freq, $2;
      }
    if (/^.*Channel/)
      {
        /^(.*:)(.+?)$/;
        push @chan, $2;
      }
    if (/^.*Encryption/)
      {
        /^(.*:)(.+?)$/;
        push @crypt, $2;
      }
    $i++;
  }
close INFILE;

for ($ARGV[0] =~ /stop/)
  {
    stopradio;
    end;
  }

for ($ARGV[0] =~ /start/)
  {
    startradio;
    print GREEN, "\n\t ]-]o   }={o   Pick a Number 1 thru ", $#mac+1,"   o}={  o[-[ \n", RESET;
    for ($c=0; $c le $#mac; $c++)
      {
        if ($crypt[$c] =~ /on/)
          {
            $l=$c+1;
            print "\n$l  ", RED, "$essid[$c]", RESET;
            next;
          }
        if ($freq[$c] !~ /g/)
          {
            $l=$c+1;
            print "\n$l  ", YELLOW, "$essid[$c]", RESET;
            next;
          }
        $l=$c+1;
        print "\n$l  ", GREEN, "$essid[$c]", RESET;
      }
    print "\n";

   $key = readkey();
   $use=$key-1;

   unless ($key !~ /[0-9+?]/ || $use>$#mac)
     {
       for ($#mac>0)
         {
           print GREEN, "\n You've chosen $essid[$use]", RESET;
           doit;
         }
       if ($#mac=0)
         {
           print RED, "\n\nSorry, bad scan. Please re-run.\n", RESET;
         }
     }

     if ($key !~ /[0-9+?]/ || $use>$#mac)
       {
         print RED, "hey \"visible\" NUMBERS only\n", RESET;
       }
     
     end;
 }
