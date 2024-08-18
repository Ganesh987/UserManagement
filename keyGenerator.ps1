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



