#!/usr/bin/perl 
 
use Mysql; 
 
require "variables.pl"; 
 
$result="false"; 
 
#set up arguments 
$ip=$ARGV[0]; 
 
$db = Mysql->connect($mysql_ip,$database,$user,$pass);

 
$db->selectdb("tor"); 
 
$query="SELECT * from registry where IP='$ip'"; 
$test=$db->query($query); 
$number=$test->numrows; 
 
if($number>0) { 
$result="true"; 
} 
 
print "$result\n";
