#!/usr/bin/perl 
 
use Mysql; 
 
require "variables.pl"; 
 
$thisquery=$ARGV[0]; 
 
$db = Mysql->connect($mysql_ip,$database,$user,$pass);

 
$db->selectdb("tor"); 
 
$test=$db->query($thisquery); 
 
while(@results = $test->fetchrow()) { 
 
 
print
"$results[0]\t$results[1]\t$results[2]\t$results[3]\t$results[4]\t$results[5]\t$results[6]\t$results[7]\n\n";

 
 
}
