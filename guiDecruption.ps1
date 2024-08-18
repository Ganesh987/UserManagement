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

# Function to decrypt a message from a file
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

# Add type for OpenFileDialog
Add-Type -AssemblyName System.Windows.Forms

# Create OpenFileDialog for encrypted file
$openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$openFileDialog.InitialDirectory = [Environment]::GetFolderPath("Desktop")
$openFileDialog.Filter = "Text files (*.txt)|*.txt|All files (*.*)|*.*"
$openFileDialog.Title = "Select the encrypted file"
$openFileDialog.ShowDialog() | Out-Null
$encryptedFilePath = $openFileDialog.FileName

# Create OpenFileDialog for key file
$openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$openFileDialog.InitialDirectory = [Environment]::GetFolderPath("Desktop")
$openFileDialog.Filter = "Text files (*.txt)|*.txt|All files (*.*)|*.*"
$openFileDialog.Title = "Select the key file"
$openFileDialog.ShowDialog() | Out-Null
$keyFilePath = $openFileDialog.FileName

# Read the key from the key file
$encryptionKeyHex = [System.IO.File]::ReadAllText($keyFilePath)
$decryptionKey = Convert-HexStringToByteArray -hexString $encryptionKeyHex

# Decrypt the message and display it
$decryptedBody = Decrypt-MessageFromFile -filePath $encryptedFilePath -key $decryptionKey
[System.Windows.Forms.MessageBox]::Show($decryptedBody, "Decrypted Message", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
