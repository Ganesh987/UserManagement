
Connect-AzureAD -Confirm

$threshold = (Get-Date).AddDays(14)
$expiringUsers = Get-AzureADUser -All $true | Where-Object {($.PasswordPolicies -contains "DisablePasswordExpiration") -and ($.PasswordExpires -le $threshold)}
$sender = "admin@you.com"
$subject = "Password will expire soon"
$body = "Your password is expiring soon. Please change it as soon as possible."
foreach ($user in $expiringUsers) {
    $recipient = $user.UserPrincipalName
    Send-MailMessage -From $sender -To $recipient -Subject $subject -Body $body -SmtpServer "smtp.you.com"
}

<#
Import-Module AzureAD
#$cred = Get-Credential
Connect-AzureAD #-Credential $cred
$users = Get-AzureADUser -All $true | Where-Object { ($_.PasswordPolicies -eq "DisablePasswordExpiration") -eq $false }
foreach ($user in $users) {
    $pwdLastChanged = Get-AzureADUserPasswordLastChangeDateTime -ObjectId $user.ObjectId
    $daysToExpiry = [math]::Round((($pwdLastChanged.AddDays(90) - (Get-Date)).TotalDays)) # Assuming default 90 days password expiry
    
    if ($daysToExpiry -le 7) {
        # Send email alert. This could be done using Send-MailMessage cmdlet or any other email sending mechanism.
    }
}
#>

<#
# Get the user information
$properties = @('DisplayName','UserPrincipalName','AccountEnabled','lastPasswordChangeDateTime','Password')
Get-MgUser -All -Property $properties | Select-Object $properties
#$properties = @('DisplayName','UserPrincipalName','AccountEnabled','lastPasswordChangeDateTime')
#$userId = 'ashwinipatil@Hexaware310.onmicrosoft.com'
#$result = Get-MgUser -UserId $userId -Property $properties
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


#Send-MailMessage -To '<recipient’s email address>' -From '<sender’s email address>' -Subject 'Your message subject' -Body 'Some important plain text!' -Credential (Get-Credential) -SmtpServer '<smtp server>' -Port 25

#>