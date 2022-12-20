#!/usr/bin/perl 
 
require "variables.pl"; 
 
$registry="ARIN"; 
$ip=$ARGV[0]; 
$torname=$ARGV[1]; 
 
$tmp=`cat $SCRIPTWORKINGDIR/tmp.txt | grep
"OrgName:"`; 
#split out the name 
#split the line out by spaces 
my @oname=split(":",$tmp); 
$orgname=$oname[1]; 
$orgname=~s/\'//g; 
$orgname=~s/\(//g; 
$orgname=~s/\)//g; 
 
$tmp=`cat $SCRIPTWORKINGDIR/tmp.txt | grep "Address: 
"`; 
chomp($tmp); 
my @des=split(":",$tmp); 
$descr.=$des[1]." "; 
$descr=~s/\'//g; 
$descr=~s/\(//g; 
$descr=~s/\)//g; 
 
$tmp=`cat $SCRIPTWORKINGDIR/tmp.txt | grep "City:  "`;

chomp($tmp); 
my @des=split(":",$tmp); 
$descr.=$des[1]." "; 
 
 
$tmp=`cat $SCRIPTWORKINGDIR/tmp.txt | grep "StateProv:
 "`; 
chomp($tmp); 
my @des=split(":",$tmp); 
$descr.=$des[1]." "; 
 
$tmp=`cat $SCRIPTWORKINGDIR/tmp.txt | grep
"PostalCode:"`; 
chomp($tmp); 
my @des=split(":",$tmp); 
$descr.=$des[1]; 
 
$tmp=`cat $SCRIPTWORKINGDIR/tmp.txt | grep
"Country:"`; 
chomp($tmp); 
my @cou=split(":",$tmp); 
$country=$cou[1]; 
$country=~s/ //g; 
 
#now insert values into database 
$cmd=`$SCRIPTWORKINGDIR/insert.pl "$orgname" "$descr"
"$country" "$registry" "$ip" "$torname"`; 
$cmd=`/bin/rm -f $SCRIPTWORKINGDIR/tmp.txt`; 
 
sleep 5;
