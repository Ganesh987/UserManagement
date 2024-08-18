
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = "Passw0rd"
New-AzureADUser -AccountEnabled $True -DisplayName "John Rogers" -PasswordProfile $PasswordProfile -MailNickName "JRogers" -UserPrincipalName "JRogers@Hexaware310.onmicrosoft.com"

# Get the user information
#$properties = @('DisplayName','UserPrincipalName','AccountEnabled','lastPasswordChangeDateTime')
#Get-MgUser -All -Property $properties | Select-Object $properties

$properties = @('DisplayName','UserPrincipalName','AccountEnabled','lastPasswordChangeDateTime')
$userId = 'ashwinipatil@Hexaware310.onmicrosoft.com'
$result = Get-MgUser -UserId $userId -Property $properties
# Get the user's last password change date and time
$result | Select-Object $properties
#[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12


$recipient = "ganesh.pavaskar@gslab.com"
$sender = "ganesh.pavaskar@gmail.com"
$subject = "Password will expire soon"
$body = "Your password is expiring soon. Please change it as soon as possible."
#foreach ($user in $result) {
#    $recipient = $user.UserPrincipalName
    Send-MailMessage -From $sender -To $recipient -Subject $subject -Body $body -SmtpServer "localhost" -Port 25
#}


