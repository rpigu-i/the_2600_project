# $language = "VBScript"
# $interface = "1.0"

Dim tavan,taban,rendim,kauntir
Dim sonuc
Dim tumsi

Sub setaddr
tumsi = "sysHfcMacAddrSet__3Hfccccccc(0x00"
do while kauntir<6
randomize
rendim = Int((tavan - taban + 1)*Rnd + taban)
sonuc= hex(rendim)
tumsi = tumsi + "," + "0x" + sonuc
kauntir = kauntir+1
loop
tumsi = tumsi + ")"
End Sub

Do while 1=1
crt.Screen.Synchronous = True
tavan = 255
taban = 17
kauntir = 1
setaddr()
crt.Screen.WaitForString "Version:"
Set shell = CreateObject("WScript.Shell")
shell.Run "netsh interface ip set address "Local Area Connection" static TFTPSERVERIPHERE 255.255.0.0 TFTPSERVERIPHERE 1"
crt.Screen.WaitForString "-> "
crt.Screen.Send "ts tScMain" & vbCr
crt.Screen.WaitForString "-> "
crt.Screen.Send tumsi & vbCr
crt.Screen.WaitForString "-> "
crt.Screen.Send "routeAdd "&Chr(34)&"TFTPSERVERIPHERE"&Chr(34)&", "&Chr(34)&"192.168.100.1"&Chr(34) & vbCr
crt.Screen.WaitForString "-> "
crt.Screen.Send "tr tScMain" & vbCr
crt.Screen.WaitForString "-> "
crt.Screen.Send "td tShell" & vbCr
crt.Screen.WaitForString "REGISTRATION SUCCESS"
shell.Run "netsh interface ip set address "Local Area Connection" source=dhcp"
crt.Screen.Synchronous = False
loop
