
# Load the iTextSharp library
$itextSharpPath = "C:\Users\Administrator\Documents\Scripts\libs\itextsharp.dll"
Add-Type -Path $itextSharpPath
Add-Type -Path "C:\Users\Administrator\Documents\Scripts\libs\BouncyCastle.Crypto.dll"

# Define a function to create a password-protected PDF
function CreatePasswordProtectedPdf {
    param (
        [string]$outputFilePath,
        [string]$password
    )
    
    $document = New-Object iTextSharp.text.Document
    $stream = [System.IO.File]::Create($outputFilePath)
    $writer = [iTextSharp.text.pdf.PdfWriter]::GetInstance($document, $stream)
    $writer.SetEncryption([System.Text.Encoding]::UTF8.GetBytes($password), [System.Text.Encoding]::UTF8.GetBytes($password), $writer.ALLOW_PRINTING, $writer.ENCRYPTION_AES_128)

    $document.Open()
    $paragraph = New-Object iTextSharp.text.Paragraph("This is a password-protected PDF document. You can only open it with the correct password.")
    $document.Add($paragraph)
    $document.Close()
    $stream.Close()
}

# Parameters for email
$smtpServer = "localhost"  # Replace with your SMTP server address
$from = "ganesh.pavaskar@gmail.com"
$to = "ganesh.pavaskar@gslab.com"
$subject = "Password-Protected PDF Attachment"
$body = "Please find the password-protected PDF attached."

# Parameters for file and password
$pdfFilePath = "C:\Users\Administrator\Documents\Scripts\input\Document.pdf"
$password = "YourPassword"

# Create the password-protected PDF
CreatePasswordProtectedPdf -outputFilePath $pdfFilePath -password $password

# Send email with attachment
try {
    $attachment = New-Object System.Net.Mail.Attachment($pdfFilePath)
    $attachment.ContentType.MediaType = "application/pdf"
    $attachment.ContentType.Name = "Document.pdf"
    
    $msg = New-Object System.Net.Mail.MailMessage $from, $to, $subject, $body
    $msg.Attachments.Add($attachment)
    
    $smtp = New-Object Net.Mail.SmtpClient($smtpServer)
    $smtp.Send($msg)
    
    Write-Host "Email sent successfully."
}
catch {
    Write-Host "Failed to send email: $_.Exception.Message"
}
finally {
    # Clean up: delete the PDF after sending
    Remove-Item $pdfFilePath -Force
}