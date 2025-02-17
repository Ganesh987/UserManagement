
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Updates an existing server.
The request body can contain one to many of the properties present in the normal server definition.
Use Update-AzPostSqlFlexibleServerConfiguration instead if you want update server parameters such as wait_timeout or net_retry_count.
.Description
Updates an existing server.
The request body can contain one to many of the properties present in the normal server definition.
Use Update-AzPostSqlFlexibleServerConfiguration instead if you want update server parameters such as wait_timeout or net_retry_count.
#>

function Update-AzPostgreSqlFlexibleServer {
    [OutputType([Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Models.Api20210601.IServerAutogenerated])]
    [CmdletBinding(DefaultParameterSetName='UpdateExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
    [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Description('Updates an existing server. The request body can contain one to many of the properties present in the normal server definition. Use Update-AzPostgreSqlFlexibleServerConfiguration instead if you want update server parameters such as wait_timeout or net_retry_count.')]
    param(
        [Parameter(ParameterSetName='UpdateExpanded', Mandatory, HelpMessage='The name of the server.')]
        [Alias('ServerName')]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Category('Path')]
        [System.String]
        ${Name},

        [Parameter(ParameterSetName='UpdateExpanded', Mandatory, HelpMessage='The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.')]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Category('Path')]
        [System.String]
        ${ResourceGroupName},

        [Parameter(ParameterSetName='UpdateExpanded', HelpMessage='The subscription ID that identifies an Azure subscription.')]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Category('Path')]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
        [System.String]
        ${SubscriptionId},

        [Parameter(ParameterSetName='UpdateViaIdentityExpanded', Mandatory, ValueFromPipeline, HelpMessage='Identity Parameter. To construct, see NOTES section for INPUTOBJECT properties and create a hash table.')]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Category('Path')]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Models.IPostgreSqlIdentity]
        ${InputObject},

        [Parameter(HelpMessage='The password of the administrator login.')]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Category('Body')]
        [System.Security.SecureString]
        ${AdministratorLoginPassword},

        [Parameter(HelpMessage='The name of the sku, e.g. Burstable_B1ms, Standard_D2ds_v4')]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Category('Body')]
        [System.String]
        ${Sku},

        [Parameter(HelpMessage='The tier of the particular SKU. Accepted values: Burstable, GeneralPurpose, Memory Optimized. Default: Burstable.')]
        [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Support.SkuTier])]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Support.SkuTier]
        ${SkuTier},

        [Parameter(HelpMessage='Enable or disable high availability feature. Allowed values: Enabled, Disabled')]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Category('Body')]
        [Validateset('Enabled', 'Disabled')]
        ${HaEnabled},

        [Parameter(HelpMessage='Backup retention days for the server. Day count is between 7 and 35.')]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Category('Body')]
        [System.Int32]
        ${BackupRetentionDay},

        [Parameter(HelpMessage='Period of time (UTC) designated for maintenance. Examples: "Sun:23:30" to schedule on Sunday, 11:30pm UTC. To set back to default pass in "Disabled"')]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Category('Body')]
        [System.String]
        ${MaintenanceWindow},

        [Parameter(HelpMessage='Max storage allowed for a server.')]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Category('Body')]
        [System.Int32]
        ${StorageInMb},

        [Parameter(HelpMessage='Application-specific metadata in the form of key-value pairs.')]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Runtime.Info(PossibleTypes=([Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Models.Api20171201.IServerUpdateParametersTags]))]
        [System.Collections.Hashtable]
        ${Tag},

        [Parameter(HelpMessage = 'The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRMContext', 'AzureCredential')]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Category('Azure')]
        [System.Management.Automation.PSObject]
        ${DefaultProfile},

        [Parameter(HelpMessage = 'Run the command as a job.')]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        ${AsJob},

        [Parameter(DontShow, HelpMessage = 'Wait for .NET debugger to attach.')]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        ${Break},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Category('Runtime')]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Runtime.SendAsyncStep[]]
        # SendAsync Pipeline Steps to be appended to the front of the pipeline.
        ${HttpPipelineAppend},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Category('Runtime')]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Runtime.SendAsyncStep[]]
        # SendAsync Pipeline Steps to be prepended to the front of the pipeline.
        ${HttpPipelinePrepend},

        [Parameter(HelpMessage = 'Run the command asynchronously.')]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        ${NoWait},

        [Parameter(DontShow)]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Category('Runtime')]
        [System.Uri]
        # The URI for the proxy server to use.
        ${Proxy},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Category('Runtime')]
        [System.Management.Automation.PSCredential]
        # Credentials for a proxy server to use for the remote call.
        ${ProxyCredential},

        [Parameter(DontShow)]
        [Microsoft.Azure.PowerShell.Cmdlets.PostgreSql.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Use the default credentials for the proxy.
        ${ProxyUseDefaultCredentials}
    )

    process {
        try {
            if ($PSBoundParameters.ContainsKey('StorageInMb')) {
                $PSBoundParameters.StorageSizeGb = [Math]::floor($PSBoundParameters['StorageInMb'] / 1024)
                $null = $PSBoundParameters.Remove('StorageInMb')
            }

            if ($PSBoundParameters.ContainsKey('Sku')) {
                $PSBoundParameters.SkuName = $PSBoundParameters['Sku']
                $null = $PSBoundParameters.Remove('Sku')
            }

            if ($PSBoundParameters.ContainsKey('HaEnabled')) {
                if ($PSBoundParameters['HaEnabled'] -eq 'Enabled'){
                    $PSBoundParameters.HighAvailabilityMode = 'ZoneRedundant'
                }
                else {
                    $PSBoundParameters.HighAvailabilityMode = $PSBoundParameters['HaEnabled']
                }
                $null = $PSBoundParameters.Remove('HaEnabled')
            }

            if ($PSBoundParameters.ContainsKey('MaintenanceWindow')) {

                $PSBoundParameters.MaintenanceWindowDayOfWeek = $null
                $PSBoundParameters.MaintenanceWindowStartHour = $null
                $PSBoundParameters.MaintenanceWindowStartMinute = $null

                if ($PSBoundParameters.MaintenanceWindow.ToLower() -eq "disabled"){
                    $PSBoundParameters.MaintenanceWindowDayOfWeek = 0
                    $PSBoundParameters.MaintenanceWindowStartHour = 0
                    $PSBoundParameters.MaintenanceWindowStartMinute = 0
                    $PSBoundParameters.MaintenanceWindowCustomWindow = "Disabled"
                }
                else {
                    $ParsedWindow = $PSBoundParameters.MaintenanceWindow -split ":"
                    $DaytoNumber = @{Mon = 1; Tue = 2; Wed = 3; Thur = 4; Fri = 5; Sat = 6; Sun = 0}

                    if ($ParsedWindow.Length -ge 1){
                        $PSBoundParameters.MaintenanceWindowDayOfWeek =  $DaytoNumber[$ParsedWindow[0]]
                    }

                    if ($ParsedWindow.Length -ge 2){
                        $PSBoundParameters.MaintenanceWindowStartHour = $ParsedWindow[1]
                    }

                    if ($ParsedWindow.Length -ge 3){
                        $PSBoundParameters.MaintenanceWindowStartMinute = $ParsedWindow[2]
                    }

                    $PSBoundParameters.MaintenanceWindowCustomWindow = "Enabled"
                }

                $null = $PSBoundParameters.Remove('MaintenanceWindow')
            }

            Az.PostgreSql.internal\Update-AzPostgreSqlFlexibleServer @PSBoundParameters
        } catch {
            throw
        }
    }
}

# SIG # Begin signature block
# MIIoJgYJKoZIhvcNAQcCoIIoFzCCKBMCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCE/IXTNgcPlMGI
# JQr4MX2ZnbBFzIHTWbwV2SsVfb3JsaCCDXYwggX0MIID3KADAgECAhMzAAADrzBA
# DkyjTQVBAAAAAAOvMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMjMxMTE2MTkwOTAwWhcNMjQxMTE0MTkwOTAwWjB0MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMR4wHAYDVQQDExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQDOS8s1ra6f0YGtg0OhEaQa/t3Q+q1MEHhWJhqQVuO5amYXQpy8MDPNoJYk+FWA
# hePP5LxwcSge5aen+f5Q6WNPd6EDxGzotvVpNi5ve0H97S3F7C/axDfKxyNh21MG
# 0W8Sb0vxi/vorcLHOL9i+t2D6yvvDzLlEefUCbQV/zGCBjXGlYJcUj6RAzXyeNAN
# xSpKXAGd7Fh+ocGHPPphcD9LQTOJgG7Y7aYztHqBLJiQQ4eAgZNU4ac6+8LnEGAL
# go1ydC5BJEuJQjYKbNTy959HrKSu7LO3Ws0w8jw6pYdC1IMpdTkk2puTgY2PDNzB
# tLM4evG7FYer3WX+8t1UMYNTAgMBAAGjggFzMIIBbzAfBgNVHSUEGDAWBgorBgEE
# AYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQURxxxNPIEPGSO8kqz+bgCAQWGXsEw
# RQYDVR0RBD4wPKQ6MDgxHjAcBgNVBAsTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEW
# MBQGA1UEBRMNMjMwMDEyKzUwMTgyNjAfBgNVHSMEGDAWgBRIbmTlUAXTgqoXNzci
# tW2oynUClTBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20vcGtpb3BzL2NybC9NaWNDb2RTaWdQQ0EyMDExXzIwMTEtMDctMDguY3JsMGEG
# CCsGAQUFBwEBBFUwUzBRBggrBgEFBQcwAoZFaHR0cDovL3d3dy5taWNyb3NvZnQu
# Y29tL3BraW9wcy9jZXJ0cy9NaWNDb2RTaWdQQ0EyMDExXzIwMTEtMDctMDguY3J0
# MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQELBQADggIBAISxFt/zR2frTFPB45Yd
# mhZpB2nNJoOoi+qlgcTlnO4QwlYN1w/vYwbDy/oFJolD5r6FMJd0RGcgEM8q9TgQ
# 2OC7gQEmhweVJ7yuKJlQBH7P7Pg5RiqgV3cSonJ+OM4kFHbP3gPLiyzssSQdRuPY
# 1mIWoGg9i7Y4ZC8ST7WhpSyc0pns2XsUe1XsIjaUcGu7zd7gg97eCUiLRdVklPmp
# XobH9CEAWakRUGNICYN2AgjhRTC4j3KJfqMkU04R6Toyh4/Toswm1uoDcGr5laYn
# TfcX3u5WnJqJLhuPe8Uj9kGAOcyo0O1mNwDa+LhFEzB6CB32+wfJMumfr6degvLT
# e8x55urQLeTjimBQgS49BSUkhFN7ois3cZyNpnrMca5AZaC7pLI72vuqSsSlLalG
# OcZmPHZGYJqZ0BacN274OZ80Q8B11iNokns9Od348bMb5Z4fihxaBWebl8kWEi2O
# PvQImOAeq3nt7UWJBzJYLAGEpfasaA3ZQgIcEXdD+uwo6ymMzDY6UamFOfYqYWXk
# ntxDGu7ngD2ugKUuccYKJJRiiz+LAUcj90BVcSHRLQop9N8zoALr/1sJuwPrVAtx
# HNEgSW+AKBqIxYWM4Ev32l6agSUAezLMbq5f3d8x9qzT031jMDT+sUAoCw0M5wVt
# CUQcqINPuYjbS1WgJyZIiEkBMIIHejCCBWKgAwIBAgIKYQ6Q0gAAAAAAAzANBgkq
# hkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24x
# EDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlv
# bjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlmaWNhdGUgQXV0aG9yaXR5
# IDIwMTEwHhcNMTEwNzA4MjA1OTA5WhcNMjYwNzA4MjEwOTA5WjB+MQswCQYDVQQG
# EwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwG
# A1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSgwJgYDVQQDEx9NaWNyb3NvZnQg
# Q29kZSBTaWduaW5nIFBDQSAyMDExMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
# CgKCAgEAq/D6chAcLq3YbqqCEE00uvK2WCGfQhsqa+laUKq4BjgaBEm6f8MMHt03
# a8YS2AvwOMKZBrDIOdUBFDFC04kNeWSHfpRgJGyvnkmc6Whe0t+bU7IKLMOv2akr
# rnoJr9eWWcpgGgXpZnboMlImEi/nqwhQz7NEt13YxC4Ddato88tt8zpcoRb0Rrrg
# OGSsbmQ1eKagYw8t00CT+OPeBw3VXHmlSSnnDb6gE3e+lD3v++MrWhAfTVYoonpy
# 4BI6t0le2O3tQ5GD2Xuye4Yb2T6xjF3oiU+EGvKhL1nkkDstrjNYxbc+/jLTswM9
# sbKvkjh+0p2ALPVOVpEhNSXDOW5kf1O6nA+tGSOEy/S6A4aN91/w0FK/jJSHvMAh
# dCVfGCi2zCcoOCWYOUo2z3yxkq4cI6epZuxhH2rhKEmdX4jiJV3TIUs+UsS1Vz8k
# A/DRelsv1SPjcF0PUUZ3s/gA4bysAoJf28AVs70b1FVL5zmhD+kjSbwYuER8ReTB
# w3J64HLnJN+/RpnF78IcV9uDjexNSTCnq47f7Fufr/zdsGbiwZeBe+3W7UvnSSmn
# Eyimp31ngOaKYnhfsi+E11ecXL93KCjx7W3DKI8sj0A3T8HhhUSJxAlMxdSlQy90
# lfdu+HggWCwTXWCVmj5PM4TasIgX3p5O9JawvEagbJjS4NaIjAsCAwEAAaOCAe0w
# ggHpMBAGCSsGAQQBgjcVAQQDAgEAMB0GA1UdDgQWBBRIbmTlUAXTgqoXNzcitW2o
# ynUClTAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYD
# VR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBRyLToCMZBDuRQFTuHqp8cx0SOJNDBa
# BgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3JsLm1pY3Jvc29mdC5jb20vcGtpL2Ny
# bC9wcm9kdWN0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFfMDNfMjIuY3JsMF4GCCsG
# AQUFBwEBBFIwUDBOBggrBgEFBQcwAoZCaHR0cDovL3d3dy5taWNyb3NvZnQuY29t
# L3BraS9jZXJ0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFfMDNfMjIuY3J0MIGfBgNV
# HSAEgZcwgZQwgZEGCSsGAQQBgjcuAzCBgzA/BggrBgEFBQcCARYzaHR0cDovL3d3
# dy5taWNyb3NvZnQuY29tL3BraW9wcy9kb2NzL3ByaW1hcnljcHMuaHRtMEAGCCsG
# AQUFBwICMDQeMiAdAEwAZQBnAGEAbABfAHAAbwBsAGkAYwB5AF8AcwB0AGEAdABl
# AG0AZQBuAHQALiAdMA0GCSqGSIb3DQEBCwUAA4ICAQBn8oalmOBUeRou09h0ZyKb
# C5YR4WOSmUKWfdJ5DJDBZV8uLD74w3LRbYP+vj/oCso7v0epo/Np22O/IjWll11l
# hJB9i0ZQVdgMknzSGksc8zxCi1LQsP1r4z4HLimb5j0bpdS1HXeUOeLpZMlEPXh6
# I/MTfaaQdION9MsmAkYqwooQu6SpBQyb7Wj6aC6VoCo/KmtYSWMfCWluWpiW5IP0
# wI/zRive/DvQvTXvbiWu5a8n7dDd8w6vmSiXmE0OPQvyCInWH8MyGOLwxS3OW560
# STkKxgrCxq2u5bLZ2xWIUUVYODJxJxp/sfQn+N4sOiBpmLJZiWhub6e3dMNABQam
# ASooPoI/E01mC8CzTfXhj38cbxV9Rad25UAqZaPDXVJihsMdYzaXht/a8/jyFqGa
# J+HNpZfQ7l1jQeNbB5yHPgZ3BtEGsXUfFL5hYbXw3MYbBL7fQccOKO7eZS/sl/ah
# XJbYANahRr1Z85elCUtIEJmAH9AAKcWxm6U/RXceNcbSoqKfenoi+kiVH6v7RyOA
# 9Z74v2u3S5fi63V4GuzqN5l5GEv/1rMjaHXmr/r8i+sLgOppO6/8MO0ETI7f33Vt
# Y5E90Z1WTk+/gFcioXgRMiF670EKsT/7qMykXcGhiJtXcVZOSEXAQsmbdlsKgEhr
# /Xmfwb1tbWrJUnMTDXpQzTGCGgYwghoCAgEBMIGVMH4xCzAJBgNVBAYTAlVTMRMw
# EQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVN
# aWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNp
# Z25pbmcgUENBIDIwMTECEzMAAAOvMEAOTKNNBUEAAAAAA68wDQYJYIZIAWUDBAIB
# BQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEO
# MAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEIJ+RtnTn1MVFxUO2C3Jgvyv8
# 2G9RW900BXfGxr4WWzy3MEIGCisGAQQBgjcCAQwxNDAyoBSAEgBNAGkAYwByAG8A
# cwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20wDQYJKoZIhvcNAQEB
# BQAEggEAouzV3P5bkw2iZePvQ8VvnZ2fQHIU7rxXDzKU2b2+6dFjNHkhfJOt+/l0
# oavQwq/hCGLK9vT2kYxW1gOEmoihLZQPDMNkpiew6lFTQk97rV15qp74MX448rw1
# +7P7dMj2iaFBFASA/Y63RCBcgiarDFSGzQFNYeatbnVRlIBB2jcE+m4zfwyIhB5o
# H/sY30baJZgh3qjz7tbV6L4gMgvlQQnAn5CBEXMZd3cnvSsidmEuT2neXDSB8k6v
# ziy3ZoJ+uwjGx3WxpokfWKeMcTBXWUzTZEpdqYpUvk/oQlLIfGyGoOT8YugGNfst
# OphMr6nMNLYFsfREQqorSkr/JUD1GaGCF5AwgheMBgorBgEEAYI3AwMBMYIXfDCC
# F3gGCSqGSIb3DQEHAqCCF2kwghdlAgEDMQ8wDQYJYIZIAWUDBAIBBQAwggFOBgsq
# hkiG9w0BCRABBKCCAT0EggE5MIIBNQIBAQYKKwYBBAGEWQoDATAxMA0GCWCGSAFl
# AwQCAQUABCAOtfI2U4r2nPHSr5L3Dqe43tH2pUxydGMEiXvG+skguAIGZhftuF0S
# GA8yMDI0MDQyMzEzMTUxMlowBIACAfSggdGkgc4wgcsxCzAJBgNVBAYTAlVTMRMw
# EQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVN
# aWNyb3NvZnQgQ29ycG9yYXRpb24xJTAjBgNVBAsTHE1pY3Jvc29mdCBBbWVyaWNh
# IE9wZXJhdGlvbnMxJzAlBgNVBAsTHm5TaGllbGQgVFNTIEVTTjo4NjAzLTA1RTAt
# RDk0NzElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2VydmljZaCCEeow
# ggcgMIIFCKADAgECAhMzAAAB8bNF9SfowBbWAAEAAAHxMA0GCSqGSIb3DQEBCwUA
# MHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdS
# ZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMT
# HU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwMB4XDTIzMTIwNjE4NDU1NVoX
# DTI1MDMwNTE4NDU1NVowgcsxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5n
# dG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9y
# YXRpb24xJTAjBgNVBAsTHE1pY3Jvc29mdCBBbWVyaWNhIE9wZXJhdGlvbnMxJzAl
# BgNVBAsTHm5TaGllbGQgVFNTIEVTTjo4NjAzLTA1RTAtRDk0NzElMCMGA1UEAxMc
# TWljcm9zb2Z0IFRpbWUtU3RhbXAgU2VydmljZTCCAiIwDQYJKoZIhvcNAQEBBQAD
# ggIPADCCAgoCggIBALG6UJm20h/xf3utb38n5DhWD0+K6AHXJrX8NHHEtbaHDLhC
# C1TePl9XvlkprpdNNCFbkKWQaXqCnWd3lUGzHglv6hTg+wwDZ+h7yA/1tA09XEgc
# wm7pNhyuuff0d1163bGR2pSHPPJJdo8WoUyTZWJ8R+P4dHomF42zYsvObwUMmb6k
# F108MtqD9H4A8hYfJ+2r2K3AzRY/lnR19DIjhaVV5RL6+i2w9tab5EqwfgVA2HNv
# S38PiK61x8Irf8sr7EuZLp2YCHsAwq4RSXyLaR1YENFxz4lZrbVIJ5/HlI+EkQWB
# iF0Y8CincbWXxPfdyqtsu1wUmrDDhNCJiIKR3KwJycgXRmpI0Adx8j1IC/eB+TLG
# pA0knexOyDkY9EX3maqBt9BuQWdTXuJhtEg8mrCBIuHIHzfdkOCbPFsqYmZ0Nptv
# NLTIaGeAdrr6DBVo5Spwd/3DqTDEyj46obdBkhzB3nAcQKzmsAlno8jIUzsB3aFF
# QUdFOLfncjtXjESBga5lvqoXHo9/jiLsCNdum1SiUNxXNgR2AtBJaK4VqNLpeDeT
# sLLxOIzkc9Qr0tkieWhPG5QtLEmYnudONSM6PnHBGYLvHZL+bGqXye8dII3U4QPb
# /AQI6i3owR71svefOgrA7xM2URK2rmxx3bkYDSAxA76o1dX/FMM4FMnzMFwZAgMB
# AAGjggFJMIIBRTAdBgNVHQ4EFgQUvLbF7n2wITRKPJyoTkStvhitLWAwHwYDVR0j
# BBgwFoAUn6cVXQBeYl2D9OXSZacbUzUZ6XIwXwYDVR0fBFgwVjBUoFKgUIZOaHR0
# cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9jcmwvTWljcm9zb2Z0JTIwVGlt
# ZS1TdGFtcCUyMFBDQSUyMDIwMTAoMSkuY3JsMGwGCCsGAQUFBwEBBGAwXjBcBggr
# BgEFBQcwAoZQaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9jZXJ0cy9N
# aWNyb3NvZnQlMjBUaW1lLVN0YW1wJTIwUENBJTIwMjAxMCgxKS5jcnQwDAYDVR0T
# AQH/BAIwADAWBgNVHSUBAf8EDDAKBggrBgEFBQcDCDAOBgNVHQ8BAf8EBAMCB4Aw
# DQYJKoZIhvcNAQELBQADggIBAOFISNIEVIJsnKXdT9CYUxbZ4s8GSeeWx8gP/uBM
# y8A0SeGrTwj0cdtuqLCoMQdK8BG8q0vuPTOcgJgFsytVKa+APFTyMAaozKIugzzT
# vzxKjf5PohlX/9RlEmoGXigzdsIhCAUajRVN5DpHNgv63XMJReaak+YzjFxJxUUB
# NePlPHsHLhKFZQLtWGbumJwOJTmKAaO6K9GHE+9ul+VuH9uyITm3Hly44kQlIb65
# ZyoHJHtMLhwa+5q8dKOTWJFdP9CNo4R4mg6d96xs528msl1ub6V5gtEjrs3dx3wH
# +y5TbW1F2DA6dOTaE65kqz+QvBpfo2wBtTL2kqwOZPKhacabJNYE+JNvaunmiCjx
# jyExTVhCzusdHmGqKUSrzyMX70fwpxxv/WKyYlMacGdEy/rxR3aXksWE5nidG2Xi
# UeuL43UvwQGDtoTwS897wJr2DPyyHYXgI5Nh3U8dx7W6Au+9ZbX5o5Kl3w2fASJ3
# jOAPv1lDGKwmrI7iUxYzMCAR4WFSbjQWyG3Ne50CxfkugKKXistsd/Bi0Y6nD0NV
# feNcBX3S0b2JFtyqO23e+Fb1P4vd8BmUx6tpZ+Ht5SY+W0xTyURA4x6Wj/V6GQgY
# 7thk4fFSp4qmYX1BpbwtdNPT3QAdniTqD612lkV8Iyi3Ib4Theo3pla0oQFCITfE
# vbsEMIIHcTCCBVmgAwIBAgITMwAAABXF52ueAptJmQAAAAAAFTANBgkqhkiG9w0B
# AQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNV
# BAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEyMDAG
# A1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlmaWNhdGUgQXV0aG9yaXR5IDIwMTAw
# HhcNMjEwOTMwMTgyMjI1WhcNMzAwOTMwMTgzMjI1WjB8MQswCQYDVQQGEwJVUzET
# MBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMV
# TWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1T
# dGFtcCBQQ0EgMjAxMDCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOTh
# pkzntHIhC3miy9ckeb0O1YLT/e6cBwfSqWxOdcjKNVf2AX9sSuDivbk+F2Az/1xP
# x2b3lVNxWuJ+Slr+uDZnhUYjDLWNE893MsAQGOhgfWpSg0S3po5GawcU88V29YZQ
# 3MFEyHFcUTE3oAo4bo3t1w/YJlN8OWECesSq/XJprx2rrPY2vjUmZNqYO7oaezOt
# gFt+jBAcnVL+tuhiJdxqD89d9P6OU8/W7IVWTe/dvI2k45GPsjksUZzpcGkNyjYt
# cI4xyDUoveO0hyTD4MmPfrVUj9z6BVWYbWg7mka97aSueik3rMvrg0XnRm7KMtXA
# hjBcTyziYrLNueKNiOSWrAFKu75xqRdbZ2De+JKRHh09/SDPc31BmkZ1zcRfNN0S
# idb9pSB9fvzZnkXftnIv231fgLrbqn427DZM9ituqBJR6L8FA6PRc6ZNN3SUHDSC
# D/AQ8rdHGO2n6Jl8P0zbr17C89XYcz1DTsEzOUyOArxCaC4Q6oRRRuLRvWoYWmEB
# c8pnol7XKHYC4jMYctenIPDC+hIK12NvDMk2ZItboKaDIV1fMHSRlJTYuVD5C4lh
# 8zYGNRiER9vcG9H9stQcxWv2XFJRXRLbJbqvUAV6bMURHXLvjflSxIUXk8A8Fdsa
# N8cIFRg/eKtFtvUeh17aj54WcmnGrnu3tz5q4i6tAgMBAAGjggHdMIIB2TASBgkr
# BgEEAYI3FQEEBQIDAQABMCMGCSsGAQQBgjcVAgQWBBQqp1L+ZMSavoKRPEY1Kc8Q
# /y8E7jAdBgNVHQ4EFgQUn6cVXQBeYl2D9OXSZacbUzUZ6XIwXAYDVR0gBFUwUzBR
# BgwrBgEEAYI3TIN9AQEwQTA/BggrBgEFBQcCARYzaHR0cDovL3d3dy5taWNyb3Nv
# ZnQuY29tL3BraW9wcy9Eb2NzL1JlcG9zaXRvcnkuaHRtMBMGA1UdJQQMMAoGCCsG
# AQUFBwMIMBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIAQwBBMAsGA1UdDwQEAwIBhjAP
# BgNVHRMBAf8EBTADAQH/MB8GA1UdIwQYMBaAFNX2VsuP6KJcYmjRPZSQW9fOmhjE
# MFYGA1UdHwRPME0wS6BJoEeGRWh0dHA6Ly9jcmwubWljcm9zb2Z0LmNvbS9wa2kv
# Y3JsL3Byb2R1Y3RzL01pY1Jvb0NlckF1dF8yMDEwLTA2LTIzLmNybDBaBggrBgEF
# BQcBAQROMEwwSgYIKwYBBQUHMAKGPmh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9w
# a2kvY2VydHMvTWljUm9vQ2VyQXV0XzIwMTAtMDYtMjMuY3J0MA0GCSqGSIb3DQEB
# CwUAA4ICAQCdVX38Kq3hLB9nATEkW+Geckv8qW/qXBS2Pk5HZHixBpOXPTEztTnX
# wnE2P9pkbHzQdTltuw8x5MKP+2zRoZQYIu7pZmc6U03dmLq2HnjYNi6cqYJWAAOw
# Bb6J6Gngugnue99qb74py27YP0h1AdkY3m2CDPVtI1TkeFN1JFe53Z/zjj3G82jf
# ZfakVqr3lbYoVSfQJL1AoL8ZthISEV09J+BAljis9/kpicO8F7BUhUKz/AyeixmJ
# 5/ALaoHCgRlCGVJ1ijbCHcNhcy4sa3tuPywJeBTpkbKpW99Jo3QMvOyRgNI95ko+
# ZjtPu4b6MhrZlvSP9pEB9s7GdP32THJvEKt1MMU0sHrYUP4KWN1APMdUbZ1jdEgs
# sU5HLcEUBHG/ZPkkvnNtyo4JvbMBV0lUZNlz138eW0QBjloZkWsNn6Qo3GcZKCS6
# OEuabvshVGtqRRFHqfG3rsjoiV5PndLQTHa1V1QJsWkBRH58oWFsc/4Ku+xBZj1p
# /cvBQUl+fpO+y/g75LcVv7TOPqUxUYS8vwLBgqJ7Fx0ViY1w/ue10CgaiQuPNtq6
# TPmb/wrpNPgkNWcr4A245oyZ1uEi6vAnQj0llOZ0dFtq0Z4+7X6gMTN9vMvpe784
# cETRkPHIqzqKOghif9lwY1NNje6CbaUFEMFxBmoQtB1VM1izoXBm8qGCA00wggI1
# AgEBMIH5oYHRpIHOMIHLMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3Rv
# bjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0
# aW9uMSUwIwYDVQQLExxNaWNyb3NvZnQgQW1lcmljYSBPcGVyYXRpb25zMScwJQYD
# VQQLEx5uU2hpZWxkIFRTUyBFU046ODYwMy0wNUUwLUQ5NDcxJTAjBgNVBAMTHE1p
# Y3Jvc29mdCBUaW1lLVN0YW1wIFNlcnZpY2WiIwoBATAHBgUrDgMCGgMVAPufsGTi
# Cwza1tT+L4zcG1GcuPT3oIGDMIGApH4wfDELMAkGA1UEBhMCVVMxEzARBgNVBAgT
# Cldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29m
# dCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENB
# IDIwMTAwDQYJKoZIhvcNAQELBQACBQDp0ZSMMCIYDzIwMjQwNDIzMDE1OTQwWhgP
# MjAyNDA0MjQwMTU5NDBaMHQwOgYKKwYBBAGEWQoEATEsMCowCgIFAOnRlIwCAQAw
# BwIBAAICI+8wBwIBAAICFk8wCgIFAOnS5gwCAQAwNgYKKwYBBAGEWQoEAjEoMCYw
# DAYKKwYBBAGEWQoDAqAKMAgCAQACAwehIKEKMAgCAQACAwGGoDANBgkqhkiG9w0B
# AQsFAAOCAQEAJOvi0xuk951CSVLzzIHY7cQjr4frWiZYK5bkY9+48bjePAeamuIu
# UYXo1yqEIYxJb2ToHjLuvV0BRuURM5fDGwKf5L85lygzurnoFtaR42Nz/1gKKz8b
# 8MUdfKhBOlQbqANe4HEXebvt7lrIWCTarjgRg8Hfm16KB6ZQx8xjOI3jBzqNCgM1
# OK8HuBwbXhNtEkCaXk3fonC7knouL0JEoQwsXfj9Y/wmsmdaWGA3rqhcqLCrI3rA
# 5Gm2/CgRsgwyrMoRDy+krJwpECvXaD1LxHb6LRRNmogysyZKd9nnR9hEaUNd2OAf
# v6yRcevMFw14Zz5nHTTPRSo1ByBdZPMQSjGCBA0wggQJAgEBMIGTMHwxCzAJBgNV
# BAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4w
# HAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29m
# dCBUaW1lLVN0YW1wIFBDQSAyMDEwAhMzAAAB8bNF9SfowBbWAAEAAAHxMA0GCWCG
# SAFlAwQCAQUAoIIBSjAaBgkqhkiG9w0BCQMxDQYLKoZIhvcNAQkQAQQwLwYJKoZI
# hvcNAQkEMSIEIN+yR26cUczQQO66SAi2jhauXK8Il96oaKGcNdK7PyZEMIH6Bgsq
# hkiG9w0BCRACLzGB6jCB5zCB5DCBvQQg1Xf9PmFLuKPBqjjrpGiwHvDASJu3RrU/
# kSojASP2EXgwgZgwgYCkfjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGlu
# Z3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBv
# cmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMAIT
# MwAAAfGzRfUn6MAW1gABAAAB8TAiBCAwuvq2Jt+ewP3jXGuGn3fwn4/TPMEj1Wzp
# RHXbBM1dOzANBgkqhkiG9w0BAQsFAASCAgCv9aNeCMnqyyZhqt4M/o6nApyRemdq
# mBN/8bMowIrxFkQXXoSjgcmckRWxWCAYc5arVoKfWveb7hZ+eqKCgoqEo/WYll1p
# UaqXhQn1Jx/lvqpC0DR9wPEJanQN3xAdwlzj2qmPmL1cRpkg3kCRsP5ZpRAGTbud
# SAMvsVaX6SVXcScBc/9lwWZ3PjPsj3kw7YepJfhDhSoP/+l/chQxjHziZv6UeBAg
# x/fRJ+Iqph8NfHhNIJ+3hTVtsO/R7v0n4Fm0GFY4BvCSs+IaZCSHx2KXvv35DUx1
# CSWSnklfZeOCrjcWEUaBWZAOesVmCYKdbO06tddtGIcWhC4KDPGEAWMycHw1E3Oi
# SReoOZ9mLVz2tS4tHMLFIjM8QI210r+XKtFb28Il0VwzwB0a5GKMSo5t/EHpIZCU
# eZdy11GFYpXfpNjXCxFshsf7HDB5veeGXZptDCEfPTp1svAAEf3k6fWWEQGjtmCF
# itkIh7F9cf32LC++z7BwfjpFZuJV+zNsn3ikgpnNwUDarw7onNB6YTx9z7T7962M
# TdcLy88o+s3B1rlwqjMeHf8a2CyvfoMMAW2MIU44P+E3qFGxyp425s+TEgGrHPsl
# kc2tr+U5VZCq5ngH8F09HItIpIW81vhJQ3jszvf06HiGGFNU+l2/Kk1gaNx1biSR
# 1nVu6TcbIWigWw==
# SIG # End signature block
