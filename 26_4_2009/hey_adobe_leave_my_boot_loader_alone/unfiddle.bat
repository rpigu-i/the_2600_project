start "dummy" "%~f1" 
ping -n 30 127.0.0.1 
dd if=c:\unfiddle\clean.img of=\\.\PhysicalDrive0 bs=1024 count=8 

