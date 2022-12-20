#!/usr/bin/perl 
 
require "variables.pl"; 
 
$registry="RIPE"; 
$ip=$ARGV[0]; 
$torname=$ARGV[1]; 
 
 
$tmp=`cat $SCRIPTWORKINGDIR/tmp.txt | grep "netname: 
"`; 
chomp($tmp); 
#split out the name 
#split the line out by spaces 
my @oname=split(":",$tmp); 
$orgname=$oname[1]; 
$orgname=~s/\'//g; 
$orgname=~s/\(//g; 
$orgname=~s/\)//g; 
 
$tmp=`cat $SCRIPTWORKINGDIR/tmp.txt | grep "descr:"`; 
chomp($tmp); 
my @des=split(":",$tmp); 
$descr=$des[1]; 
$descr=~s/\'//g; 
$descr=~s/\(//g; 
$descr=~s/\)//g; 
 
$tmp=`cat $SCRIPTWORKINGDIR/tmp.txt | grep
"country:"`; 
chomp($tmp); 
my @cou=split(":",$tmp); 
$country=$cou[1]; 
$country=~s/ //g; 
 
#now insert values into database 
$cmd=`$SCRIPTWORKINGDIR/insert.pl "$orgname" "$descr"
"$country" "$registry" "$ip" "$torname"`; 
 
$cmd=`/bin/rm -f $SCRIPTWORKINGDIR/tmp.txt`; 
 
sleep 5;
