# Generate a secure 32-byte encryption key
function Generate-EncryptionKey {
    $aes = [System.Security.Cryptography.Aes]::Create()
    $aes.KeySize = 256
    $aes.GenerateKey()
    $key = $aes.Key
    return $key
}

# Generate and display the encryption key
$encryptionKey = Generate-EncryptionKey
$keyHex = [BitConverter]::ToString($encryptionKey) -replace '-'
Write-Output "Your encryption key (Hex): $keyHex"

# Save the encryption key to a file (to share with the user securely)
$keyFilePath = "C:\Users\Administrator\Documents\Scripts\mailContent\encryption_key.txt"  # Change the path as needed
[System.IO.File]::WriteAllText($keyFilePath, $keyHex)

# Function to convert hex string to byte array
function Convert-HexStringToByteArray {
    param (
        [string]$hexString
    )
    $bytes = @()
    for ($i = 0; $i -lt $hexString.Length; $i += 2) {
        $bytes += [Convert]::ToByte($hexString.Substring($i, 2), 16)
    }
    return ,$bytes
}

# Function to encrypt a message using AES encryption
function Encrypt-MessageToFile {
    param (
        [string]$message,
        [byte[]]$key,
        [string]$filePath
    )
    
    # Convert the message to byte array
    $messageBytes = [System.Text.Encoding]::UTF8.GetBytes($message)

    # Create AES encryption object
    $aes = [System.Security.Cryptography.Aes]::Create()
    $aes.Key = $key
    $aes.GenerateIV()

    # Create an encryptor and memory stream
    $encryptor = $aes.CreateEncryptor($aes.Key, $aes.IV)
    $memoryStream = New-Object System.IO.MemoryStream

    # Create a crypto stream
    $cryptoStream = New-Object System.Security.Cryptography.CryptoStream($memoryStream, $encryptor, [System.Security.Cryptography.CryptoStreamMode]::Write)
    $cryptoStream.Write($messageBytes, 0, $messageBytes.Length)
    $cryptoStream.FlushFinalBlock()

    # Get the encrypted bytes and IV
    $encryptedBytes = $memoryStream.ToArray()
    $IV = $aes.IV

    # Combine IV and encrypted bytes
    $result = $IV + $encryptedBytes
    $encryptedMessage = [System.Convert]::ToBase64String($result)

    # Write the encrypted message to a file
    [System.IO.File]::WriteAllText($filePath, $encryptedMessage)

    # Cleanup
    $cryptoStream.Close()
    $memoryStream.Close()
    $aes.Dispose()
}

# User information

$userEmail = "ganesh.pavaskar@gslab.com"
$userName = "New User"
$subject = "Welcome to the Company"
$smtpServer = "localhost"
$fromEmail = "ganesh.pavaskar@gmail.com"
$encryptionKeyHex = $keyHex  # Use the generated Hex key

# Convert the hex key to byte array
$encryptionKey = Convert-HexStringToByteArray -hexString $encryptionKeyHex

# Email body
$emailBody = @"
Username = Ganesh
Password = Passw0rd1
"@

# Encrypt the email body and save to a file
$encryptedFilePath = "C:\Users\Administrator\Documents\Scripts\mailContent\encrypted_message.txt"  # Change the path as needed
Encrypt-MessageToFile -message $emailBody -key $encryptionKey -filePath $encryptedFilePath

# Send the email with the encrypted file as an attachment
Send-MailMessage -To $userEmail -From $fromEmail -Subject $subject -Body "Please find the encrypted content attached." -Attachments $encryptedFilePath -SmtpServer $smtpServer

