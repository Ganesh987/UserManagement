Connect-AzureAD

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
				
				$testArray = [System.Collections.ArrayList]@();
				#$arrayList = New-Object -TypeName System.Collections.ArrayList
				
				if ($groupName1 -ne $null) { $testArray.Add($groupName1) }
				if ($groupName2 -ne $null) { $testArray.Add($groupName2) }
				if ($groupName3 -ne $null) { $testArray.Add($groupName3) }
				if ($groupName4 -ne $null) { $testArray.Add($groupName4) }
				if ($groupName5 -ne $null) { $testArray.Add($groupName5) }
				
				Write-Host "********************************************"
				Write-Host "test -" $testArray
				Write-Host "********************************************"
				
				$userIDx = (Get-AzureADuser -objectid $userPrincipalName).objectid
				
				foreach($igroup in $testArray){ 

					$groupobid = (Get-AzureADGroup -SearchString $igroup).objectid
					Write-Host "groupobid&&& -" $groupobid
					Add-AzureADGroupMember -ObjectId $groupobid -RefObjectId $userIDx
					Start-Sleep -Seconds 2
				}
				
				Write-Host "------------------------------------------------------------"
				

				
				#Clear-Variable -Name groupName
				#Clear-Variable -Name groupIDx	
			}
			
	} catch {
		Write-Error -Message "Unable to assign group to user(license via group), please ensure input data."
		exit
	}		
}

LicenseAssignGroup-AzureAD

Disconnect-AzureAD









#New-MgGroupMember -GroupId 97fffa8e-9a50-4999-b22f-24e52e4bea1b -DirectoryObjectId 9d281a74-fb71-4bca-befc-02ec1428a91c


#Add-AzureADGroupMember -ObjectId $groupid.ObjectId -RefObjectId $user

#Add-AzureADGroupMember -ObjectId 97fffa8e-9a50-4999-b22f-24e52e4bea1b -RefObjectId 0b9ff5f6-47cb-4687-b380-7501f1b60681


#$userID = (Get-AzureADuser -objectid $userPrincipalName).objectid













<#
$gname ="TestGroup"
$uname ="anikam@Hexaware310.onmicrosoft.com"
$groupid=(Get-AzADGroup -DisplayName $gname).Id
$members=@()
$members+=(Get-AzADUser -DisplayName $uname).Id
$members+=(Get-AzADServicePrincipal -ApplicationId $appid).Id
Add-AzADGroupMember -TargetGroupObjectId $groupid -MemberObjectId $members
#>