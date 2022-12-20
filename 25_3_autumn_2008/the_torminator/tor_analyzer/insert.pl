#!/usr/bin/perl 
 
use Mysql; 
 
require "variables.pl"; 
 
#set up arguments 
$reg_name=$ARGV[0]; 
$descr=$ARGV[1]; 
$country=$ARGV[2]; 
$registry=$ARGV[3]; 
$ip=$ARGV[4]; 
$tor_name=$ARGV[5]; 
 
$db = Mysql->connect($mysql_ip,$database,$user,$pass);

 
$db->selectdb("tor"); 
 
$query="INSERT INTO tor_ips (IP,TOR_NAME,DATE_UPDATED)
VALUES ('$ip','$tor_name',now())"; 
$test=$db->query($query); 
 
$query="INSERT INTO registry
(IP,REG_NAME,DESCR,COUNTRY,REGISTRY,DATE_ENTERED,DATE_UPDATED)
VALUES
('$ip','$reg_name','$descr','$country','$registry',now(),now())";

$test=$db->query($query);
