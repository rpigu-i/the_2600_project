#!/bin/bash
# This script allows you to change your MAC address. Proper
# syntax is as follows:

# change-mac home       # Changes MAC Address to Original
# change-mac <MAC>      # Changes MAC Address to One Specified
# change-mac random     # Changes MAC Address Randomly

# .macs.dat required format:
#   XX:XX:XX:XX:XX:XX

file=~/bin/.macs.dat
if [ -z $file ] ; then
        echo "File $file Does Not Exist"
        exit 0
fi
NB_LINES=$(expr $(wc -l $file | sed -e 's/ *//' | cut -f1 -d " "))
NB_RAND=0
while [ "$NB_RAND" -eq 0 ]
        do
        NB_RAND=$(expr $RANDOM \% $NB_LINES)
done
random=`sed -n "${NB_RAND}p;${NB_RAND}q" $file`
 
if [ "$1" == home ]; then
        ifconfig eth0 down
        ifconfig eth0 hw ether XX:XX:XX:XX:XX:XX # Change to your original MAC address
        ifconfig eth0 up
        echo "Original MAC Address Restored."
        exit 0
elif [ "$1" == random ]; then
        ifconfig eth0 down
        ifconfig eth0 hw ether $random
        ifconfig eth0 up
        echo "MAC Address Randomly Changed To $random"
        exit 1
elif [ "$1" ]; then
        ifconfig eth0 down
        ifconfig eth0 hw ether $1
        ifconfig eth0 up
        echo "MAC Address Changed To $1."
        exit 2
else
        echo "change-mac home      # Changes MAC Address to Original"
        echo "change-mac <MAC>     # Changes MAC Address to One Specified"
        echo "change-mac random    # Changes MAC Address Randomly"
        exit 3
fi
