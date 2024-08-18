
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

			$userid = (Get-AzureADuser -objectid "anikam@Hexaware310.onmicrosoft.com").objectid

			$Groups = Get-AzureADUserMembership -ObjectId $userID 
			Write-Host "Successfully -" $Groups
			
			foreach($Group in $Groups){ 
				try { 
					Remove-AzureADGroupMember -ObjectId $Group.ObjectID -MemberId $userID -erroraction Stop 
				}
				catch {
					write-host "$($Group.displayname) membership cannot be removed via Azure cmdlets."
					#Remove-DistributionGroupMember -identity $group.mail -member $userid -BypassSecurityGroupManagerCheck # -Confirm:$false
				}
			}	
			
			
			try {
				# Log in to Azure AD interactively
				Set-AzureADUser -ObjectID "anikam@Hexaware310.onmicrosoft.com" -AccountEnabled $false
				Write-Host "User disabled - " $UserId.DisplayName
			} catch {
				Write-Error "Failed to log in to Azure AD. Error: $_"
			}	
			