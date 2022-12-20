#!/usr/bin/perl 
 
use Mysql; 
 
require "variables.pl"; 
 
#set up arguments 
$ip=$ARGV[0]; 
$tor_name=$ARGV[1]; 
 
$db = Mysql->connect($mysql_ip,$database,$user,$pass);

 
$db->selectdb("tor"); 
 
#if the record wasn't in the previous run, even if
we've see 
#the ip before, it won't be in tor_ips, so we need to
reinsert it 
#if the record was in the previous run, this will
generate a 
#duplicate key error but causes no harm 
$query="insert into tor_ips (IP,TOR_NAME,DATE_UPDATED)
values ('$ip','$tor_name',now())"; 
$test=$db->query($query); 
 
#if the record was in the previous run, update the
date 
$query="Update registry set DATE_UPDATED=now() where
IP='$ip'"; 
$test=$db->query($query); 
 
#if the record was in the previous run, update the
date 
$query="Update tor_ips set DATE_UPDATED=now() where
IP='$ip'"; 
$test=$db->query($query);
