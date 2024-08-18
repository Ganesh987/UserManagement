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




function Decrypt-MessageFromFile {
    param (
        [string]$filePath,
        [byte[]]$key
    )

    # Read the encrypted message from the file
    $encryptedMessage = [System.IO.File]::ReadAllText($filePath)

    # Convert the encrypted message to byte array
    $encryptedBytes = [System.Convert]::FromBase64String($encryptedMessage)

    # Extract the IV from the encrypted message
    $IV = $encryptedBytes[0..15]
    $cipherText = $encryptedBytes[16..($encryptedBytes.Length - 1)]

    # Create AES decryption object
    $aes = [System.Security.Cryptography.Aes]::Create()
    $aes.Key = $key
    $aes.IV = $IV

    # Create a decryptor and memory stream
    $decryptor = $aes.CreateDecryptor($aes.Key, $aes.IV)
    $memoryStream = New-Object System.IO.MemoryStream

    # Create a crypto stream
    $cryptoStream = New-Object System.Security.Cryptography.CryptoStream($memoryStream, $decryptor, [System.Security.Cryptography.CryptoStreamMode]::Write)
    $cryptoStream.Write($cipherText, 0, $cipherText.Length)
    $cryptoStream.FlushFinalBlock()

    # Get the decrypted bytes and convert to string
    $decryptedBytes = $memoryStream.ToArray()
    $decryptedMessage = [System.Text.Encoding]::UTF8.GetString($decryptedBytes)

    # Cleanup
    $cryptoStream.Close()
    $memoryStream.Close()
    $aes.Dispose()

    return $decryptedMessage
}

# Example usage
$encryptedFilePath = "C:\path\to\encrypted_message.txt"  # Path to the encrypted file
$decryptionKeyHex = "YourHexKeyHere"  # Same key used for encryption

# Convert the hex key to byte array
$decryptionKey = Convert-HexStringToByteArray -hexString $decryptionKeyHex

$decryptedBody = Decrypt-MessageFromFile -filePath $encryptedFilePath -key $decryptionKey
Write-Output $decryptedBody


<############
function Decrypt-Message {
    param (
        [string]$encryptedMessage,
        [byte[]]$key
    )
    
    # Convert the encrypted message to byte array
    $encryptedBytes = [System.Convert]::FromBase64String($encryptedMessage)

    # Extract the IV from the encrypted message
    $IV = $encryptedBytes[0..15]
    $cipherText = $encryptedBytes[16..($encryptedBytes.Length - 1)]

    # Create AES decryption object
    $aes = [System.Security.Cryptography.Aes]::Create()
    $aes.Key = $key
    $aes.IV = $IV

    # Create a decryptor and memory stream
    $decryptor = $aes.CreateDecryptor($aes.Key, $aes.IV)
    $memoryStream = New-Object System.IO.MemoryStream

    # Create a crypto stream
    $cryptoStream = New-Object System.Security.Cryptography.CryptoStream($memoryStream, $decryptor, [System.Security.Cryptography.CryptoStreamMode]::Write)
    $cryptoStream.Write($cipherText, 0, $cipherText.Length)
    $cryptoStream.FlushFinalBlock()

    # Get the decrypted bytes and convert to string
    $decryptedBytes = $memoryStream.ToArray()
    $decryptedMessage = [System.Text.Encoding]::UTF8.GetString($decryptedBytes)

    # Cleanup
    $cryptoStream.Close()
    $memoryStream.Close()
    $aes.Dispose()

    return $decryptedMessage
}

# Example usage
$encryptedMessage = "T3qHq7zFeUdQx1Cp4MSQlbMOfu3TIHuqSGgs35mGByrjxBbxF68XSm/NpsejhE1QSazpPESzkC5liLzbA0LeDa8GKFkth5rIvllfB4ftuS+0OPL9Wh7MsB6+wGfvL6ylCQNL9f05wC6/DM08X1eihAr4GrNkb8GXSmmR8WmMcSw="  # Replace with the actual encrypted message
$decryptionKeyHex = "C26D6A5B2DE42FB4D3BD03A349E8300164A78AB1DEB6644B6D073E0E50ED84AD"  # Same key used for encryption

# Convert the hex key to byte array
$decryptionKey = Convert-HexStringToByteArray -hexString $decryptionKeyHex

$decryptedBody = Decrypt-Message -encryptedMessage $encryptedMessage -key $decryptionKey
Write-Output $decryptedBody

#############>