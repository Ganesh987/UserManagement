$passwordtostore = "7K9CBgvc4rttvfctrsef6PVHqnP6fDdwhatevervtfdscttzSc"
$secureStringPWD = $passwordtostore | ConvertTo-SecureString -AsPlainText -Force
$secureStringText = $secureStringPWD | ConvertFrom-SecureString
Set-Content "C:\Users\Administrator\Documents\Scripts\input\encrypted.hash" $secureStringText -NoNewline


$password = Get-Content $passwordFile -Raw | ConvertTo-SecureString
$credential = New-Object System.Management.Automation.PsCredential($username, $password)