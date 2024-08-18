
# Define the message to encrypt
$message = "This is a confidential message."

# Convert the message to a secure string
$secureMessage = ConvertTo-SecureString -String $message -AsPlainText -Force

# Encrypt the message using a password (symmetric encryption)
$encryptedMessage = Protect-CmsMessage -To "ganesh.pavaskar@gslab.com" -Content $secureMessage -OutFile "C:\Users\Administrator\Documents\Scripts\test\EncryptedMessage.p7"

Write-Host "Message encrypted successfully."
