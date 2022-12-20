#!/usr/bin/perl 
 
require "variables.pl"; 
 
 
$arin_whois="192.149.252.44"; 
$ripe_whois="193.0.0.135"; 
$apnic_whois="202.12.29.13"; 
$lacnic_whois="200.160.2.15"; 
$afrinic_whois="196.216.2.1"; 
$registry="ARIN"; 
 
#set up date constraints 
$year=`date +%G`; 
chomp($year); 
$month=`date +%m`; 
chomp($month); 
$day=`date +%d`; 
chomp($day); 
$hour=`date +%k`; 
chomp($hour); 
$minute=`date +%M`; 
chomp($minute); 
$second=`date +%S`; 
chomp($second); 
$purgedate="$year-$month-$day $hour:$minute:00"; 
 
#delay for about 5 seconds to give the script 
sleep 3; 
$scriptstarttime="$year-$month-$day
$hour:$minute:$second"; 
 
$cmd=`echo "Purge time: $purgedate" >
$SCRIPTWORKINGDIR/stats.log`; 
$cmd=`echo "Script start time: $scriptstarttime" >>
$SCRIPTWORKINGDIR/stats.log`; 
 
#first cat out the routers into routers.txt 
#uncomment out next line when ready 
$cmd=`cat $USERHOMEDIR/.tor/$TORCACHEFILE | grep
"router " > $SCRIPTWORKINGDIR/routers.txt`; 
 
if ((-s "$SCRIPTWORKINGDIR/routers.txt") < 1) { 
 
#check to make sure cat cmd did not fail 
#this happens if tor hangs and will delete 
#the entire database- BAD!!! 
exit; 
 
} else { 
 
open(ROUTERS,"$SCRIPTWORKINGDIR/routers.txt"); 
 
while(<ROUTERS>) { 
#for each line in routers.txt 
 
#pull out the tor name and IP 
chomp(); 
$line=$_; 
#split the line out by spaces 
($hold,$tor_name,$ip) = split,$line," "; 
 
#check to see if IP is in database 
$is_ip_in_database=`$SCRIPTWORKINGDIR/check_ip.pl
$ip`; 
print "Checking to see if $ip is in database...\n"; 
chomp($is_ip_in_database); 
 
if($is_ip_in_database eq "true" ) { 
#if it is update the datetimestamp 
print "IP is in database. Updating DATE_UPDATED...\n";

 
$cmd=`$SCRIPTWORKINGDIR/update_date.pl $ip $tor_name`;

 
} else { 
#if it is not contact ARIN and run query using whois
and > tmp.txt 
 
print "IP is not in database. Checking with ARIN
first...\n"; 
 
$cmd=`whois -h $arin_whois $ip >
$SCRIPTWORKINGDIR/tmp.txt`; 
$parseripe="$SCRIPTWORKINGDIR/parse_ripe.pl"; 
$parseapnic="$SCRIPTWORKINGDIR/parse_apnic.pl"; 
$parselacnic="$SCRIPTWORKINGDIR/parse_lacnic.pl"; 
$parseafrinic="$SCRIPTWORKINGDIR/parse_afrinic.pl"; 
$parsearin="$SCRIPTWORKINGDIR/parse_arin.pl"; 
 
#check tmp.txt to see if OrgID contains
APNIC,RIPE,AFRINIC,or LACNIC 
 
$orgid=`cat $SCRIPTWORKINGDIR/tmp.txt | grep "OrgID"`;

 
 
if((index($orgid,"APNIC")>=0) ||
(index($orgid,"RIPE")>=0) ||
(index($orgid,"LACNIC")>=0) ||
(index($orgid,"AFRINIC")>=0)) { 
#if it does contact that registry using whois and >
tmp.txt 
#parse out identifying info and insert into database 
 
chomp($orgid); 
print "Checking $orgid registry...\n"; 
 
        if(index($orgid,"RIPE")>=0) { 
          $cmd=`whois -h $ripe_whois $ip >
$SCRIPTWORKINGDIR/tmp.txt`; 
          $cmd=`$SCRIPTWORKINGDIR/parse_ripe.pl $ip
$tor_name`; 
 
        } else { 
                if(index($orgid,"APNIC")>=0) { 
                   $cmd=`whois -h $apnic_whois $ip >
$SCRIPTWORKINGDIR/tmp.txt`; 
                  
$cmd=`$SCRIPTWORKINGDIR/parse_apnic.pl $ip $tor_name`;

                } else { 
 
                       if(index($orgid,"LACNIC")>=0) {

                            $cmd=`whois -h
$lacnic_whois $ip > $SCRIPTWORKINGDIR/tmp.txt`; 
                           
$cmd=`$SCRIPTWORKINGDIR/parse_lacnic.pl $ip
$tor_name`; 
                        }else { 
                              $cmd=`whois -h
$afrinic_whois $ip > $SCRIPTWORKINGDIR/tmp.txt`; 
                             
$cmd=`$SCRIPTWORKINGDIR/parse_afrinic.pl $ip
$tor_name`; 
                        } 
 
                } 
 
 
        } 
 
} else { 
#if OrgID didn't contain other registries and is not
null or "" 
#insert into database 
 
    if($orgid eq "") { 
 
print "ORGID is blank. Special ARIN issue.\n"; 
 
	#open the tmp file and read in five lines 
	open(ORGID,"$SCRIPTWORKINGDIR/tmp.txt"); 
        $_=<ORGID>; 
        chomp($_); 
        $_=<ORGID>; 
        chomp($_); 
        $_=<ORGID>; 
        chomp($_); 
        $_=<ORGID>; 
        chomp($_); 
        $_=<ORGID>; 
        chomp($_); 
        $_ = m/\((.*)\)/; 
 
	#now call ARIN whois to get the real info 
	$cmd=`whois -h $arin_whois $1 >
$SCRIPTWORKINGDIR/tmp.txt`; 
 
	#now call the parse_arin script 
	$cmd=`$SCRIPTWORKINGDIR/parse_arin.pl $ip $tor_name`;

 
    } else { 
      #write out this ARIN record to database 
        $cmd=`$SCRIPTWORKINGDIR/parse_arin.pl $ip
$tor_name`; 
    } 
 
} 
 
} 
 
 
}#end while ROUTERS 
 
$year=`date +%G`; 
chomp($year); 
$month=`date +%m`; 
chomp($month); 
$day=`date +%d`; 
chomp($day); 
$hour=`date +%k`; 
chomp($hour); 
$minute=`date +%M`; 
chomp($minute); 
$second=`date +%S`; 
chomp($second); 
$scriptendtime="$year-$month-$day
$hour:$minute:$second"; 
 
#purge old data in database 
$cmd=`$SCRIPTWORKINGDIR/purge.pl '$purgedate'`; 
 
#now update the stats 
$cmd=`echo "Script end time: $scriptendtime" >>
$SCRIPTWORKINGDIR/stats.log`; 
$cmd=`$SCRIPTWORKINGDIR/stats.pl >>
$SCRIPTWORKINGDIR/stats.log`; 
 
#remove routers.txt 
$cmd=`/bin/rm -f $SCRIPTWORKINGDIR/routers.txt`; 
}#end if at cat check 
 
#now kill tor 
$cmd=`$SCRIPTWORKINGDIR/killtor.pl`; 
 
#now delete the tor directory 
$cmd=`/bin/rm -Rf $USERHOMEDIR/.tor`; 
 
exit;
