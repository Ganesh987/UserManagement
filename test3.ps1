# Create a user in Azure AD with given details
# 
# Check input data is present in userOnboardingInput.csv file and provide necessary information. 
#
# Copy the program text and save with file type .ps1
#


<#
Name [displayName] Required
User name [userPrincipalName] Required
Initial password [passwordProfile] Required
Block sign in (Yes/No) [accountEnabled] Required
First name [givenName]
Last name [surname]
Job title [jobTitle]
Department [department]
Usage location [usageLocation]
Street address [streetAddress]
State or province [state]
Country or region [country]
Office [physicalDeliveryOfficeName]
City [city]
ZIP or postal code [postalCode]
Office phone [telephoneNumber]
Mobile phone [mobile]
#>

Import-Csv C:\Users\Administrator\Documents\Scripts\input\userinput.csv |`
    ForEach-Object {
		
		$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
		$PasswordProfile.Password = $_."passwordProfile"
		
        $displayName = $_."displayName"
        $userPrincipalName = $_."userPrincipalName"
		#$passwordProfile = $_."passwordProfile"
		$accountEnabled  =$_."accountEnabled"
		$givenName  =$_."givenName"
		$surname  =$_."surname"
		$nickname =$_."mailNickName"
		$usertype =$_."userType"
		$jobTitle  =$_."jobTitle"
		$department  =$_."department"
		$usageLocation  =$_."usageLocation"
		$streetAddress  =$_."streetAddress"
		$state  =$_."state"
		$country  =$_."country"
		$physicalDeliveryOfficeName  =$_."physicalDeliveryOfficeName"
		$city  =$_."city"
		$postalCode  =$_."postalCode"
		$telephoneNumber  =$_."telephoneNumber"
		$mobile  =$_."mobile"		

		
		Write-Host "Customer Name: " $displayName
		Write-Host "Customer Name: " $userPrincipalName
		Write-Host "Customer Name: " $passwordProfile
		Write-Host "Customer Name: " $accountEnabled

		try {
			
		New-AzureADUser -DisplayName $displayName `
						-UserPrincipalName $userPrincipalName `
						-PasswordProfile $PasswordProfile `
						-AccountEnabled $True `
						-GivenName $givenName `
						-Surname $surname `
						-JobTitle $jobTitle `
						-Department $department `
						-UsageLocation $usageLocation `
						-StreetAddress $streetAddress `
						-State $state `
						-Country $country `
						-PhysicalDeliveryOfficeName $physicalDeliveryOfficeName `
						-City $city `
						-PostalCode $postalCode `
						-TelephoneNumber $telephoneNumber `
						-Mobile $mobile `
						-MailNickName $nickname ` 						 `
						-UserType $usertype				

		} catch {
			Write-Error -Message "Unable to Create User"
			exit
		}
		
		Write-Host "User is created successfully."
		
		#Send email invite to user
		$recipient = "ganesh.pavaskar@gslab.com"
		$sender = "ganesh.pavaskar@gmail.com"
		$subject = "Welcome to Cinq Care"
		$body = "Welcome to Cinq Care. Please access below link and reset your password
		
		Please only act on this email if you trust the organization represented below. 
		In rare cases, individuals may receive fraudulent invitations from bad actors posing as legitimate companies. 
		If you were not expecting this invitation, proceed with caution.

		---------------------------------------------------------------------------------------------------------------------------------
		Organization:  Hexaware
		Domain:  Hexaware310.onmicrosoft.com
 
		Accept this invitation by clicking on https://myapplications.microsoft.com/?tenantid=78a47eb7-61a1-4891-8ca5-b3f0b7162924.
		
		-------------------------------------------------------------------------------------------------------------------------- ------"
		
		
	try {
		Write-Host "Sending mail to User"
		Send-MailMessage -From $sender -To $recipient -Subject $subject -Body $body -SmtpServer "localhost" -Port 25
    } catch {
		Write-Error -Message "Unable to send email. Please check SMTP server logs."
		exit
    }

}








#$inputNumber = Read-Host -Prompt "Phone Number"

#if ($Phone -contains $inputNumber)
#    {
#    Write-Host "Customer Exists!"
#    $Where = [array]::IndexOf($Phone, $inputNumber)
#    Write-Host "Customer Name: " $Name[$Where]
#    }



<#$params = @{
    AccountEnabled = $true
    DisplayName = "Mike Finnegan"
    PasswordProfile = $PasswordProfile
    UserPrincipalName = "FwF@Motor.onmicrosoft.com
    MailNickName = "Finnegan"
}
New-AzureADUser @params

$Name = @()
$Phone = @()
$email = @()
$nickname = @()
#>