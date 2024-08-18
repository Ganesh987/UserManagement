# Create a user in Cinq Care Azure AD with given details in userOnboardingInput.csv input file.
# 
# Check input data is present in userOnboardingInput.csv file and provide necessary information. 
#
# This is a powershell script and save with file type .ps1
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

# Import the AzureAD module
Import-Module AzureAD

# Function to log in to Azure AD
function Login-AzureAD {
    try {
        # Log in to Azure AD interactively
        $aadUserCredential = Connect-AzureAD -ErrorAction Stop
        Write-Host "Successfully logged in as: $($aadUserCredential.Account)"
    } catch {
        Write-Error "Failed to log in to Azure AD. Error: $_"
    }
}

# Call the login function
Login-AzureAD

#Create user in Azure AD
function CreateUser-AzureAD {
	
	try {
		
		Import-Csv C:\Users\Administrator\Documents\Scripts\input\userOnboardingInput.csv |`  
			ForEach-Object {
							
				$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
				$PasswordProfile.Password = $_."passwordProfile"
				
				$recipientPersonalMail = $_.recipientPersonalMail
				
				$displayName = $_."displayName"
				$userPrincipalName = $_."userPrincipalName"
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
					Write-Error -Message "Unable to Create User "$displayName", check input file data is correct or if user is already present."
					exit
				}
				
				Write-Host "SUCCESS! User "$displayName" is created successfully."
				
				#Send email invite to user
				$sender = "cinqcare.noreply@gmail.com"
				$subject = "Welcome to Cinq Care!"
				$body = "
				Dear "+$displayName+",
				
				We are thrilled to welcome you to Cinq Care! We are excited to have you on our team and look forward to the contributions you will make.
				--------------------------------------------------------------------------------------------------------------------------------------------------
				
				Organization:  CinqCare
				Domain:  cinqcare.onmicrosoft.com

				Please access below link to accept invitation, use mentioned credentials for first login and reset your password.
				
				Accept this invitation by clicking on https://myapplications.microsoft.com/?tenantid=78a47eb7-61a1-4891-8ca5-b3f0b7162924.
				
				Username: "+$userPrincipalName+"
				Password: "+$PasswordProfile.Password+"
				
				--------------------------------------------------------------------------------------------------------------------------------------------------
				
				Note: Our help desk team is ready to assist Monday through Friday from 7 AM to 10 PM EST and can be reached by phone at +1 866-524-6748 or by emailing ITHelpDesk@Cinq.Care.
				
				Thanks & Regards,
				Cinq Care Team
				"
			try {
				Write-Host "Sending invite mail to User" $displayName
				Send-MailMessage -From $sender -To $recipientPersonalMail -Subject $subject -Body $body -SmtpServer "localhost" -Port 25
				Write-Host "Invitation mail sent to User" $displayName
			} catch {
				Write-Error -Message "Unable to send email to user. Please check SMTP server logs."
				exit
			}
			
			Start-Sleep -Seconds 5

		}

	} catch {
		Write-Error -Message "Unable to find or read input file"
		exit
	}

} #End function CreateUser-AzureAD


#LicenseAssignGroup function to assign licenses via groups to user

function LicenseAssignGroup-AzureAD {
	
	try {
		Import-Csv C:\Users\Administrator\Documents\Scripts\input\userinput.csv |`
			ForEach-Object {
				
				$userPrincipalName = $_."userPrincipalName"
				
				$verifyUser=Get-AzureADUser -Filter "userPrincipalName eq '$userPrincipalName'"
				if ($verifyUser -ne $null) { 
					Write-Host "User "$userPrincipalName" is PRESENT in directory."
				} else { 
					Write-Host "Seems user "$userPrincipalName" NOT PRESENT in directory, please verify."
					exit 
				}
				
				$groupName1 = $_."groupName1"
				$groupName2 = $_."groupName2"
				$groupName3 = $_."groupName3"
				$groupName4 = $_."groupName4"
				$groupName5 = $_."groupName5"
				
				$grpArray = [System.Collections.ArrayList]@();
				#$arrayList = New-Object -TypeName System.Collections.ArrayList
				
				if ($groupName1 -ne $null) { $grpArray.Add($groupName1) }
				if ($groupName2 -ne $null) { $grpArray.Add($groupName2) }
				if ($groupName3 -ne $null) { $grpArray.Add($groupName3) }
				if ($groupName4 -ne $null) { $grpArray.Add($groupName4) }
				if ($groupName5 -ne $null) { $grpArray.Add($groupName5) }
				
				Write-Host "********************************************"
				Write-Host "test -" $grpArray
				Write-Host "********************************************"
				
				$userobID = (Get-AzureADuser -objectid $userPrincipalName).objectid
				
				foreach($igroup in $grpArray){ 

					$groupobid = (Get-AzureADGroup -SearchString $igroup).objectid
					Write-Host "groupobid&&& -" $groupobid
					Add-AzureADGroupMember -ObjectId $groupobid -RefObjectId $userobID
					Start-Sleep -Seconds 2
				}
				
				Write-Host "------------------------------------------------------------"

			}
			
	} catch {
		Write-Error -Message "Unable to assign group to user(license via group), please ensure input data."
		exit
	}		
}#End function CreateUser-AzureAD LicenseAssignGroup-AzureAD

#Create new user 
CreateUser-AzureAD

#Assign license via groups
LicenseAssignGroup-AzureAD

#Disconnect
Disconnect-AzureAD