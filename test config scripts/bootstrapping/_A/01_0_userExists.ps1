### ensure the appropriate user exists
#helpful list of flags: https://www.hofferle.com/modify-local-user-account-flags-with-powershell/
#example script: http://powershell.com/cs/blogs/tips/archive/2011/09/12/creating-local-admins.aspx
$username = "USER"
$password = "PASSWORD"
$computername = $env:computername
$computer=[adsi]"WinNT://$computername,computer"
$user = $computer.Create("user", $username)
try{
$user.Setinfo()
}catch{
#the user exists already
$user = [adsi]"WinNT://$computername/$username,user"
}
$user.setpassword($password)
#set flags: doesn't require password & password never expires
$user.userflags = 65536 -bor 32
$user.Setinfo()
#add to administrators group
$group = [adsi]("WinNT://$computername/administrators,group")
try{
$group.add("WinNT://$username,user")
}catch{
#already in the group
}

### setup auto-login
#http://blogs.interfacett.com/how-autologon-microsoft-windows-using-powershell
$path = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
try{
new-itemproperty -path $path -name AutoAdminLogon -value 1 -erroraction stop
}catch{
set-itemproperty -path $path -name AutoAdminLogon -value 1
}
try{
new-itemproperty -path $path -name DefaultUserName -value $username -erroraction stop
}catch{
set-itemproperty -path $path -name DefaultUserName -value $username
}
try{
new-itemproperty -path $path -name DefaultPassword -value $password -erroraction stop
}catch{
set-itemproperty -path $path -name DefaultPassword -value $password
}
### disable the intro video
#http://social.technet.microsoft.com/Forums/windows/en-US/91839d35-49da-4ba2-b6b2-7b448e5f22a4/can-we-skip-the-long-windows-8-intro-video-each-time-a-new-user-logs-onto-a-machine?forum=w8itproinstall
$path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
try{
new-itemproperty -path $path -name EnableFirstLogonAnimation -value 0 -erroraction stop
}catch{
set-itemproperty -path $path -name EnableFirstLogonAnimation -value 0
}
