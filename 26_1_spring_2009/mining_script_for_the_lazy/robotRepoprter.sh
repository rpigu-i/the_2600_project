#!/bin/bash
# robotReporter.sh -- a script for creating web server robot.txt clickable
reports
# created by KellyKeeton.com
version=.06
# dont forget to chmod 755 robotReporter.sh or there will be no 31337
h4x0r1ng
if [ "$1" = "" ]; then #deal with command line nulls
echo
echo robotReporter$version - Robots.txt report generator
echo will download and convert the robots.txt
echo on a domain to a HTML clickable map.
echo
echo Usage: robotReporter.sh example.com -b
echo
echo   -b keep orginal of the downloaded robots.txt
echo
exit
fi
wget -m -nd HTTP://$1/robots.txt -o /dev/null #download the robots.txt file
if [ -f robots.txt ]; then #if the file is there do it
if [ "$2" = "-b" ]; then # dont delete the robots.txt file
cp robots.txt robots_$1.html
mv robots.txt robots_$1.txt
echo "###EOF Created on $(date +%c) with host $1" >> robots_$1.txt
echo "###Created with robotReporter $version - KellyKeeton.com" >>
robots_$1.txt
else
mv robots.txt robots_$1.html
fi
#html generation using sed
sed -i "s/#\(.*\)/ \r\n#\1<br>/" robots_$1.html # parse comments
sed -i "/Sitemap:/s/: \(.*\)/ <a href=\"\1\">\1<\/a> <br>/" robots_$1.html #
parse the sitemap lines
sed -i "/-agent:/s/$/<br>/" robots_$1.html #parse user agent lines
sed -i "/-delay:/s/$/<br>/" robots_$1.html #parse user agent lines
sed -i "/llow:/s/\/\(.*\)/ <a href=\"http:\/\/$1\/\1\">\1<\/a> <br>/"
robots_$1.html # parse all Dis/Allow lines
echo "<br> Report ran on $(date +%c) with host <a href=\"http://$1\">$1</a>
<br> Created with robotReporter $version - <a
href=\"http://www.kellykeeton.com\">KellyKeeton.com</a>" >> robots_$1.html
echo report written to $(pwd)/robots_$1.html
#done
else #wget didnt pull the file
echo $1 has no robots.txt to report on.
fi
#EOF

