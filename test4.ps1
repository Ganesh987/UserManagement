#$azureAplicationId ="AshwiniPatil@Hexaware310.onmicrosoft.com"
#$azureTenantId= "78a47eb7-61a1-4891-8ca5-b3f0b7162924"
#$azurePassword = ConvertTo-SecureString "Thinkpad@123#" -AsPlainText -Force
#$psCred = New-Object System.Management.Automation.PSCredential($azureAplicationId , $azurePassword)
#Add-AzureRmAccount -Credential $psCred -TenantId $azureTenantId  -ServicePrincipal


#$Perms = Get-ManagementRole -Cmdlet New-ServicePrincipal  
#$Perms | foreach {Get-ManagementRoleAssignment -Role $_.Name -Delegating $false | Format-Table -Auto Role,RoleAssigneeType,RoleAssigneeName}

# STEP 3: Encrypt
$OID = New-Object System.Security.Cryptography.Oid 2.16.840.1.101.3.4.1.42
$AId = New-Object System.Security.Cryptography.Pkcs.AlgorithmIdentifier ($OID, 256)

$SignatureBytes = $SignedCMS.Encode()
$MIMEMessage2 = New-Object system.Text.StringBuilder 
$MIMEMessage2.AppendLine('Content-Type: application/pkcs7-mime; smime-type=enveloped-data;name=smime.p7m') | Out-Null 
$MIMEMessage2.AppendLine('Content-Transfer-Encoding: base64') | Out-Null 
$MIMEMessage2.AppendLine() | Out-Null 
$MIMEMessage2.AppendLine([Convert]::ToBase64String($SignedMessageBytes)) | Out-Null

Byte[]] $BodyBytes = [System.Text.Encoding]::UTF8.GetBytes($MIMEMessage2.ToString())

ContentInfo = New-Object System.Security.Cryptography.Pkcs.ContentInfo (,$BodyBytes)

$CMSRecipient = New-Object System.Security.Cryptography.Pkcs.CmsRecipient $ChosenCertificate 
$EnvelopedCMS = New-Object System.Security.Cryptography.Pkcs.EnvelopedCms( $ContentInfo, $AId)
$EnvelopedCMS.Encrypt($CMSRecipient) 
[Byte[]] $EncryptedBytes = $EnvelopedCMS.Encode() 


----------------------------------------------------------------------------------------------------



# Replace these variables with your actual values
$recipientPublicKeyFilePath = "C:\Path\To\Recipient\PublicKey.pem"
$emailSubject = "Encrypted Email Subject"
$emailBody = "This is the encrypted email body."

# Read recipient's public key from file
$recipientPublicKey = Get-Content $recipientPublicKeyFilePath

# Convert the public key string into a .NET object
$rsaProvider = New-Object System.Security.Cryptography.RSACryptoServiceProvider
$rsaProvider.ImportSubjectPublicKeyInfo($recipientPublicKey, [ref]$null)

# Convert email body to bytes
$bytesToEncrypt = [System.Text.Encoding]::UTF8.GetBytes($emailBody)

# Encrypt the email body using recipient's public key
$encryptedBytes = $rsaProvider.Encrypt($bytesToEncrypt, $false)

# Convert encrypted bytes to Base64 string (to make it email-friendly)
$encryptedMessage = [Convert]::ToBase64String($encryptedBytes)

# Now you can send the $encryptedMessage via email using your preferred method
# For example, send-mailmessage cmdlet can be used to send the encrypted message

# Example of sending the encrypted email using Send-MailMessage
$smtpServer = "your.smtp.server"
$from = "sender@example.com"
$to = "recipient@example.com"
Send-MailMessage -SmtpServer $smtpServer -From $from -To $to -Subject $emailSubject -Body $encryptedMessage -BodyAsHtml



