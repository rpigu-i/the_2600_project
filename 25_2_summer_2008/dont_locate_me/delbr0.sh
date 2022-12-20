#!/bin/sh 
# delbr0.sh part of skyhack 2008 
ifconfig br0 down 
brctl delif br0 eth0 
brctl delif br0 ath0 
brctl delbr br0 
wlanconfig ath0 destroy 
ifconfig wifi0 up 
ifconfig wifi0 down 
wlanconfig ath0 create wlandev wifi0 wlanmode Managed -bssid 
