#!/usr/bin/perl 
 
#usage: ./parse.pl [tor_cache_file]
[IP_segments_test_file] [registry] 
#Registry is either ARIN,APNIC,RIPE,LACNIC, or AFRINIC

 
#SET .wgetrc to local proxy to use TOR. 
#Edit this script to support whatever user you are
using. 
#You don't have to use TOR but if you do, make sure
Privoxy 
#and TOR are both running before executing this script

#If you don't want to use TOR, just comment out the
line below 
$cmd=`/bin/echo "http_proxy=127.0.0.1:8118" >
/home/user/.wgetrc`; 
 
#location of the main tor cache file 
$tor_cache_file=$ARGV[0]; 
 
#file with list of IP segments to test 
$entity=$ARGV[1]; 
 
#which registry we want to search against 
$registry=$ARGV[2]; 
$registry_url=""; 
 
#Note that the entity IP segment file lives in the
entity directory!!! 
$entityfile=$entity."/"."$entity.txt"; 
open (ENTFILE,"$entityfile"); 
 
while(<ENTFILE>) { 
 
#find out which registry we're running against and set
variable 
#Note that the below registry URLs may change without
notice 
if($registry eq "APNIC") { 
$registry_url="http://www.apnic.net/apnic-bin/whois.pl?searchtext=";

 
} else { 
        if($registry eq "RIPE") { 
       
$registry_url="http://www.ripe.net/fcgi-bin/whois?form_type=simple\\&ful

l_query_string=\\&do_search=Search\\&searchtext="; 
 
        } else { 
                    if($registry eq "LACNIC") { 
                       
$registry_url="http://lacnic.net/cgi-bin/lacnic/whois?lg

=EN\\&query="; 
 
 
        } else { 
                                if($registry eq
"AFRINIC") { 
       
$registry_url="http://www.afrinic.net/cgi-bin/whois?searchtext=";

 
        } else { 
               
$registry_url="http://ws.arin.net/whois/?queryinput=";

        } 
 
 
        } 
 
        } 
 
} 
 
chomp(); 
 
#read in the IP segment we are testing against 
$oct=$_; 
 
#cat out the regular tor cache file for the 'router'
lines > tmp.txt 
#note the space before $oct- it is needed due to the
file format 
$cmd=`/bin/cat $tor_cache_file | grep 'router' | grep
' $oct'> tmp.txt`; 
 
open (OCTFILE,"tmp.txt"); 
 
        while(<OCTFILE>) { 
 
        chomp(); 
        $line=$_; 
        #split the line out by spaces 
        ($hold,$tor_name,$ip) = split,$line," "; 
 
        #Now for each IP go out to see if it is in
whatever registry passed in 
        $cmd2=`/usr/bin/wget -O
$entity/$registry/$ip.html $registry_url$ip`; 
 
        #We need to delay since some registries see
multiple calls coming 
        #from an IP as an attempt to data mine- esp.
RIPE. 
	#sleep 5 seconds 
        sleep 5; 
 
        } 
 
}
