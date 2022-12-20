#!/usr/bin/perl 
 
@exec=`ps -ef | grep "/usr/local/bin/tor" | grep
--invert-match "grep /usr/local/bin/tor" | grep
--invert-match "*tor_analyzer*"`; 
 
foreach $line (@exec) { 
 
($part1,$part2,$part3,$part4,$part5,$part6,$part7,$part8)
= split / /,$line; 
 
#print "$part6\n"; 
 
#depending on the pid number assigned, both parts must
be checked 
$exec2=`kill -9 $part6`; 
$exec2=`kill -9 $part7`; 
$exec2=`kill -9 $part8`; 
 
 
 
 
 
}
