# Decomission a user from Azure AD and remove assigned application roles.
# 
# Check input data is present in userDecomInput.csv file and provide necessary information. 
#
# This is a powershell script and save with file type .ps1
#

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

function RemoveUser-AzureAD {
	
	try {
		Import-Csv C:\Users\Administrator\Documents\Scripts\input\userDecomInput.csv |`
			ForEach-Object {
			
			$userPrincipalName = $_."userPrincipalName"
			
			$UserId = Get-AzureADUser -Filter "userPrincipalName eq '$userPrincipalName'"
			
			Write-Host "User disable operation started for: " $UserId.DisplayName
			#Write-Host "##########: " $UserId.ObjectId

			$objectID = $UserId.ObjectId
			#Write-Host "##########: " $objectID

			#Remove manager assignment
			Remove-AzureADUserManager -ObjectId $objectID

			#Remove refresh tokens
			Revoke-AzureADUserAllRefreshToken -ObjectId $objectID

			#Removal of application assigned
			$data = @()
			$data = Get-AzureADUserAppRoleAssignment -ObjectId $objectID

			if($data -ne $null){
				
				foreach ($obId in $data) {
					$appAssignObjectId = $obId.ObjectId
					Write-Host "Application assignment will be removed for user "$userPrincipalName" with Object ID:" $obId.ObjectId
					Remove-AzureADUserAppRoleAssignment -ObjectId $objectID -AppRoleAssignmentId $appAssignObjectId
				}
			} else {
				Write-Host "No any application assinment present respective to User" $userPrincipalName
			}
			
			
			$id = (Get-AzureADuser -objectid $userPrincipalName).objectid
			#Group removal
			$Groups = Get-AzureADUserMembership -ObjectId $id
			#Write-Host "Successfully -" $Groups
			
			foreach($Group in $Groups){ 
				try { 
					Remove-AzureADGroupMember -ObjectId $Group.ObjectID -MemberId $id -erroraction Stop
					write-host "$($Group.displayname) group membership removed successfully"
				}
				catch {
					write-host "$($Group.displayname) membership cannot be removed via Azure cmdlets."
					#Remove-DistributionGroupMember -identity $group.mail -member $userid -BypassSecurityGroupManagerCheck # -Confirm:$false
				}
			}	
			
			#Disable user
			try {
				Set-AzureADUser -ObjectID $userPrincipalName -AccountEnabled $false
				Write-Host "$($UserId.DisplayName) user disabled in Azure AD"
			} catch {
				Write-Error "Failed to remove user $($UserId.DisplayName) in to Azure AD. Error: $_"
			}			
			
			<#
			#User removal from Azure AD
			try {
				Remove-AzureADUser -ObjectId $objectID
				Write-Host "User removed - " $UserId.DisplayName
			} catch {
				Write-Error "Failed to log in to Azure AD. Error: $_"
			}		
			#>	
			
		}

	} catch {
		Write-Error -Message "Unable to find input file OR User is not present in directory"
		exit
	}


}#End function

#Remove user
RemoveUser-AzureAD

#Disconnect
Disconnect-AzureAD