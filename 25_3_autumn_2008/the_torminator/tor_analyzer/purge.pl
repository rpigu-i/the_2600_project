#!/usr/bin/perl 
 
use Mysql; 
 
require "variables.pl"; 
 
$purgedate=$ARGV[0]; 
 
$db = Mysql->connect($mysql_ip,$database,$user,$pass);

 
$db->selectdb("tor"); 
 
$query="DELETE from tor_ips where DATE_UPDATED <
'$purgedate'"; 
 
$test=$db->query($query);
