#Set passwords for all accounts
$Usernames = Get-WmiObject -class win32_useraccount -filter "LocalAccount='True'"
foreach ($Username in $Usernames) {
    net user $Username.Name CyberPatriot! /passwordreq:yes /logonpasswordchg:no | out-null }
wmic UserAccount set PasswordExpires=True | out-null
wmic UserAccount set Lockout=False | out-null
Get-WmiObject -Class Win32_UserAccount | 
 ?{$_.LocalAccount -eq $True -and $_.Lockout -eq $True}| 
 % {
 $User = $_
 $User.Lockout = $false
 $User.Put()
}