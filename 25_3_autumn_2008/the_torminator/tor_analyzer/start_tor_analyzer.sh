#!/bin/sh 
 
#edit the below line wherever your tor executable is
located 
RESULT=`ps -efw | grep '/usr/local/bin/tor' | grep
--invert-match 'grep'` 
 
if [[ $RESULT > 0 ]] 
then 
echo "Script is already running. Do not start another
process." 
else 
        #script is not running. Okay to start 
        /usr/local/bin/tor & 
 
        #sleep for 3 minutes to give tor time to
settle down 
        sleep 180 
 
        #edit the below line with your own values 
        /home/user/tor/scripts/tor_analyzer.pl 
fi