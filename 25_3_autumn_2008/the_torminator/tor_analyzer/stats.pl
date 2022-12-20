#!/usr/bin/perl 
 
use Mysql; 
 
require "variables.pl"; 
 
$db = Mysql->connect($mysql_ip,$database,$user,$pass);

 
$db->selectdb("tor"); 
 
$test=$db->query("select count(*) from tor_ips"); 
$result=$test->fetchrow(); 
print "Total Number of TOR nodes:\t\t$result\n"; 
 
$test=$db->query("select count(*) from
registry,tor_ips where registry.COUNTRY='US' and
registry.IP=tor_ips.IP"); 
$result=$test->fetchrow(); 
print "Total Number of US nodes:\t\t$result\n"; 
 
$test=$db->query("select count(*) from
registry,tor_ips where registry.COUNTRY='DE' and
registry.IP=tor_ips.IP"); 
$result=$test->fetchrow(); 
print "Total Number of German nodes:\t\t$result\n"; 
 
$test=$db->query("select count(*) from
registry,tor_ips where registry.COUNTRY='RU' and
registry.IP=tor_ips.IP"); 
$result=$test->fetchrow(); 
print "Total Number of Russian nodes:\t\t$result\n"; 
 
$test=$db->query("select count(*) from
registry,tor_ips where registry.COUNTRY='CN' and
registry.IP=tor_ips.IP"); 
$result=$test->fetchrow(); 
print "Total Number of Chinese nodes:\t\t$result\n"; 
 
$test=$db->query("select count(*) from
registry,tor_ips where registry.COUNTRY='GB' and
registry.IP=tor_ips.IP"); 
$result=$test->fetchrow(); 
print "Total Number of British nodes:\t\t$result\n"; 
 
$test=$db->query("select count(*) from
registry,tor_ips where registry.COUNTRY='FR' and
registry.IP=tor_ips.IP"); 
$result=$test->fetchrow(); 
print "Total Number of French nodes:\t\t$result\n"; 
 
$test=$db->query("select count(*) from
registry,tor_ips where registry.COUNTRY='IT' and
registry.IP=tor_ips.IP"); 
$result=$test->fetchrow(); 
print "Total Number of Italian nodes:\t\t$result\n"; 
 
$test=$db->query("select count(*) from
registry,tor_ips where registry.COUNTRY='SE' and
registry.IP=tor_ips.IP"); 
$result=$test->fetchrow(); 
print "Total Number of Swedish nodes:\t\t$result\n"; 
 
$test=$db->query("select count(*) from
registry,tor_ips where registry.COUNTRY='FI' and
registry.IP=tor_ips.IP"); 
$result=$test->fetchrow(); 
print "Total Number of Finish nodes:\t\t$result\n"; 
 
$test=$db->query("select count(*) from
registry,tor_ips where registry.COUNTRY='JP' and
registry.IP=tor_ips.IP"); 
$result=$test->fetchrow(); 
print "Total Number of Japanese nodes:\t\t$result\n"; 
 
$test=$db->query("select count(*) from
registry,tor_ips where registry.REGISTRY='ARIN' and
registry.IP=tor_ips.IP"); 
$result=$test->fetchrow(); 
print "Total Number of ARIN nodes:\t\t$result\n"; 
 
$test=$db->query("select count(*) from
registry,tor_ips where registry.REGISTRY='RIPE' and
registry.IP=tor_ips.IP"); 
$result=$test->fetchrow(); 
print "Total Number of RIPE nodes:\t\t$result\n"; 
 
$test=$db->query("select count(*) from
registry,tor_ips where registry.REGISTRY='APNIC' and
registry.IP=tor_ips.IP"); 
$result=$test->fetchrow(); 
print "Total Number of APNIC nodes:\t\t$result\n"; 
 
$test=$db->query("select count(*) from
registry,tor_ips where registry.REGISTRY='LACNIC' and
registry.IP=tor_ips.IP"); 
$result=$test->fetchrow(); 
print "Total Number of LACNIC nodes:\t\t$result\n"; 
 
$test=$db->query("select count(*) from
registry,tor_ips where registry.REGISTRY='AFRINIC' and
registry.IP=tor_ips.IP"); 
$result=$test->fetchrow(); 
print "Total Number of AFRINIC nodes:\t\t$result\n";
