#!/bin/bash

# Find an unused IP-address
# It'll be stored in $a.$b.$c.$d

a=172
let "b=$RANDOM % 16+16" # from 16 to 32
let "c=$RANDOM % 255"   # from 0 to 255
let "d=($RANDOM % 127)*2" # from 0 to 254 only odd adresses Server
let "d2=$d+1"           #last number of client


#If first address free   and second address free  write configuration
ping -n -c 3 $a.$b.$c.$d || ping -n -c 3 $a.$b.$c.$d2 || write_configuration_files.sh $a.$b.$c.$d $a.$b.$c.$d2
echo $a.$b.$c.$d
echo $a.$b.$c.$d2
