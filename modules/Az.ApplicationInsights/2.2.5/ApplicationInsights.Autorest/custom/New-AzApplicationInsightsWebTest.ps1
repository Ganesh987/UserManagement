
# ----------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# Code generated by Microsoft (R) AutoRest Code Generator.Changes may cause incorrect behavior and will be lost if the code
# is regenerated.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Creates or updates an Application Insights web test definition.
.Description
Creates or updates an Application Insights web test definition.
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Outputs
Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Models.Api20220615.IWebTest
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

GEOLOCATION <IWebTestGeolocation[]>: A list of where to physically run the tests from to give global coverage for accessibility of your application.
  [Location <String>]: Location ID for the WebTest to run from.

REQUESTHEADER <IHeaderField[]>: List of headers and their values to add to the WebTest call.
  [Name <String>]: The name of the header.
  [Value <String>]: The value of the header.
.Link
https://learn.microsoft.com/powershell/module/az.applicationinsights/new-azapplicationinsightswebtest
#>
function New-AzApplicationInsightsWebTest {
    [OutputType([Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Models.Api20220615.IWebTest])]
    [CmdletBinding(DefaultParameterSetName='CreateStandard', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory)]
        [Alias('WebTestName')]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Path')]
        [System.String]
        # The name of the Application Insights WebTest resource.
        ${Name},
    
        [Parameter(Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Path')]
        [System.String]
        # The name of the resource group.
        # The name is case insensitive.
        ${ResourceGroupName},
    
        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Path')]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
        [System.String]
        # The ID of the target subscription.
        ${SubscriptionId},
    
        [Parameter(Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Body')]
        [System.String]
        # Resource location
        ${Location},
    
        [Parameter(ParameterSetName = "CreateClassic")]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Body')]
        [System.String]
        # The XML specification of a WebTest to run against an application.
        ${Configuration},
    
        [Parameter(ParameterSetName = "CreateStandard")]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Body')]
        [System.Management.Automation.SwitchParameter]
        # When set, this value makes the ContentMatch validation case insensitive.
        ${ContentIgnoreCase},
    
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Body')]
        [System.String]
        # Content to look for in the return of the WebTest.
        # Must not be null or empty.
        ${ContentMatch},
    
        [Parameter(ParameterSetName = "CreateStandard")]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Body')]
        [System.Management.Automation.SwitchParameter]
        # When true, validation will pass if there is a match for the ContentMatch string.
        # If false, validation will fail if there is a match
        ${ContentPassIfTextFound},
    
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Body')]
        [System.String]
        # User defined description for this WebTest.
        ${Description},
    
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Body')]
        [System.Management.Automation.SwitchParameter]
        # Is the test actively being monitored.
        ${Enabled},
    
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Body')]
        [System.Int32]
        # Interval in seconds between test runs for this WebTest.
        # Default value is 300.
        ${Frequency},
    
        [AllowEmptyCollection()]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Models.Api20220615.IWebTestGeolocation[]]
        # A list of where to physically run the tests from to give global coverage for accessibility of your application.
        # To construct, see NOTES section for GEOLOCATION properties and create a hash table.
        ${GeoLocation},
    
        [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Support.WebTestKindEnum])]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Support.WebTestKindEnum]
        # The kind of web test this is, valid choices are ping, multistep, and standard.
        ${Kind},
    
        [Parameter(ParameterSetName = "CreateStandard")]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Body')]
        [System.String]
        # Base64 encoded string body to send with this web test.
        ${RequestBody},
    
        [Parameter(ParameterSetName = "CreateStandard")]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Body')]
        [System.Management.Automation.SwitchParameter]
        # Follow redirects for this web test.
        ${RequestFollowRedirect},
    
        [Parameter(ParameterSetName = "CreateStandard")]
        [AllowEmptyCollection()]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Models.Api20220615.IHeaderField[]]
        # List of headers and their values to add to the WebTest call.
        # To construct, see NOTES section for REQUESTHEADER properties and create a hash table.
        ${RequestHeader},

        [Parameter(ParameterSetName = "CreateStandard")]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Body')]
        [System.String]
        # Http verb to use for this web test.
        ${RequestHttpVerb},
    
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Body')]
        [System.Management.Automation.SwitchParameter]
        # Parse Dependent request for this WebTest.
        ${RequestParseDependent},
    
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Body')]
        [System.String]
        # Url location to test.
        ${RequestUrl},
    
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Body')]
        [System.Management.Automation.SwitchParameter]
        # Allow for retries should this WebTest fail.
        ${RetryEnabled},
    
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Body')]
        [System.Int32]
        # Validate that the WebTest returns the http status code provided.
        ${RuleExpectedHttpStatusCode},
    
        [Parameter(ParameterSetName = "CreateStandard")]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Body')]
        [System.Management.Automation.SwitchParameter]
        # When set, validation will ignore the status code.
        ${RuleIgnoreHttpsStatusCode},
    
        [Parameter(ParameterSetName = "CreateStandard")]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Body')]
        [System.Int32]
        # A number of days to check still remain before the the existing SSL cert expires.
        # Value must be positive and the SSLCheck must be set to true.
        ${RuleSslCertRemainingLifetimeCheck},
    
        [Parameter(ParameterSetName = "CreateStandard")]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Body')]
        [System.Management.Automation.SwitchParameter]
        # Checks to see if the SSL cert is still valid.
        ${RuleSslCheck},
    
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Runtime.Info(PossibleTypes=([Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Models.Api20220615.IWebtestsResourceTags]))]
        [System.Collections.Hashtable]
        # Resource tags
        ${Tag},
    
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Body')]
        [System.String]
        # User defined name if this WebTest.
        ${TestName},
    
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Body')]
        [System.Int32]
        # Seconds until this WebTest will timeout and fail.
        # Default value is 30.
        ${Timeout},
    
        [Parameter()]
        [Alias('AzureRMContext', 'AzureCredential')]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Azure')]
        [System.Management.Automation.PSObject]
        # The credentials, account, tenant, and subscription used for communication with Azure.
        ${DefaultProfile},
    
        [Parameter(DontShow)]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Wait for .NET debugger to attach
        ${Break},
    
        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Runtime')]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Runtime.SendAsyncStep[]]
        # SendAsync Pipeline Steps to be appended to the front of the pipeline
        ${HttpPipelineAppend},
    
        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Runtime')]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Runtime.SendAsyncStep[]]
        # SendAsync Pipeline Steps to be prepended to the front of the pipeline
        ${HttpPipelinePrepend},
    
        [Parameter(DontShow)]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Runtime')]
        [System.Uri]
        # The URI for the proxy server to use
        ${Proxy},
    
        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Runtime')]
        [System.Management.Automation.PSCredential]
        # Credentials for a proxy server to use for the remote call
        ${ProxyCredential},
    
        [Parameter(DontShow)]
        [Microsoft.Azure.PowerShell.Cmdlets.ApplicationInsights.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Use the default credentials for the proxy
        ${ProxyUseDefaultCredentials}
    )
    
    process {
        try {
            if ($PSBoundParameters['Kind'] -eq 'ping') {
                if (!$PSBoundParameters.ContainsKey("Configuration")) {
                    $guid01 = (New-Guid).ToString()
                    $guid02 = (New-Guid).ToString()
                    if ($PSBoundParameters.ContainsKey('ContentMatch')) {
                        $pingConfigurationRules = "<ValidationRules> 
                                                    <ValidationRule  Classname=`"Microsoft.VisualStudio.TestTools.WebTesting.Rules.ValidationRuleFindText, Microsoft.VisualStudio.QualityTools.WebTestFramework, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a`"  DisplayName=`"Find Text`"  Description=`"Verifies the existence of the specified text in the response.`"  Level=`"High`"  ExectuionOrder=`"BeforeDependents`">
                                                        <RuleParameters> 
                                                        <RuleParameter Name=`"FindText`" Value=`"$($PSBoundParameters['ContentMatch'])`" /> 
                                                        <RuleParameter Name=`"IgnoreCase`" Value=`"False`" /> 
                                                        <RuleParameter Name=`"UseRegularExpression`" Value=`"False`" /> 
                                                        <RuleParameter Name=`"PassIfTextFound`" Value=`"True`" /> 
                                                        </RuleParameters> 
                                                    </ValidationRule> 
                                                </ValidationRules>"
                        
                    }else {
                        $pingConfigurationRules = $null
                    }
                    $pingConfigurationTemplate = "<WebTest  Name=`"$($PSBoundParameters['TestName'])`"  Id=`"$($guid01)`"  Enabled=`"True`"  CssProjectStructure=`"`"  CssIteration=`"`"  Timeout=`"$($PSBoundParameters['Timeout'])`"  WorkItemIds=`"`"  xmlns=`"http://microsoft.com/schemas/VisualStudio/TeamTest/2010`"  Description=`"`"  CredentialUserName=`"`"  CredentialPassword=`"`"  PreAuthenticate=`"True`"  Proxy=`"default`"  StopOnError=`"False`"  RecordedResultFile=`"`"  ResultsLocale=`"`"> 
                                                    <Items> 
                                                        <Request Method=`"Get`"  Guid=`"$($guid02)`"  Version=`"1.1`"  Url=`"$($PSBoundParameters['RequestUrl'])`"  ThinkTime=`"0`"  Timeout=`"$($PSBoundParameters['Timeout'])`"  ParseDependentRequests=`"$($PSBoundParameters['RequestParseDependent'])`"  FollowRedirects=`"True`"  RecordResult=`"True`"  Cache=`"False`"  ResponseTimeGoal=`"0`"  Encoding=`"utf-8`"  ExpectedHttpStatusCode=`"$($PSBoundParameters['RuleExpectedHttpStatusCode'])`"  ExpectedResponseUrl=`"`"  ReportingName=`"`"  IgnoreHttpStatusCode=`"False`" /> 
                                                    </Items>
                                                    $($pingConfigurationRules)
                                                </WebTest>"
                    $PSBoundParameters["Configuration"] = $pingConfigurationTemplate

                }
                $null = $PSBoundParameters.Remove("ContentMatch");
                $null = $PSBoundParameters.Remove("RequestUrl");
                $null = $PSBoundParameters.Remove("RequestParseDependent");
                $null = $PSBoundParameters.Remove("RuleExpectedHttpStatusCode"); 
            }
            Az.ApplicationInsights.internal\New-AzApplicationInsightsWebTest @PSBoundParameters
        } catch {
            throw
        }
    }

}
    
# SIG # Begin signature block
# MIInvwYJKoZIhvcNAQcCoIInsDCCJ6wCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCA60JaFcZeQUQdA
# DMKJ+dUHZkA9ZU60fITxQUaXiJXuMqCCDXYwggX0MIID3KADAgECAhMzAAADrzBA
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
# /Xmfwb1tbWrJUnMTDXpQzTGCGZ8wghmbAgEBMIGVMH4xCzAJBgNVBAYTAlVTMRMw
# EQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVN
# aWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNp
# Z25pbmcgUENBIDIwMTECEzMAAAOvMEAOTKNNBUEAAAAAA68wDQYJYIZIAWUDBAIB
# BQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEO
# MAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEIGl8k/WOj6z0bttC4o6hCjJy
# psg0bZgecsN+D+tB0WSVMEIGCisGAQQBgjcCAQwxNDAyoBSAEgBNAGkAYwByAG8A
# cwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20wDQYJKoZIhvcNAQEB
# BQAEggEAtASTTsaMQo3IKLrDMwpyc/yiL6TeywJfqLNeUUXNEYzvFkaqool65vCZ
# FQjOcz093l4PxnpmWppgRMWFyk1YCl+nqU2H23bDUbvrf3PCnqr6c+GBJXuFIfjz
# kG3MNlPL+OOErwFF6Lm+Fl+myP+c5t9zzBc/Q8ZmRua2wE9oC+xFYBQTz7YFmAD8
# LOpOMoBL9pyLewtNxoKyaklha2iYpdziuW8d7DUsmpSH9aj1nAhDPiAw8YGK8AiD
# MAXOFfnmZEAzLQdugEb+PhdW0CUMGwAYQOQj3sPHilH2cc0ld3e6/TvvCpcp4pnz
# iV09g8Qmss+oGlWMOua1gaJNMTkvZ6GCFykwghclBgorBgEEAYI3AwMBMYIXFTCC
# FxEGCSqGSIb3DQEHAqCCFwIwghb+AgEDMQ8wDQYJYIZIAWUDBAIBBQAwggFZBgsq
# hkiG9w0BCRABBKCCAUgEggFEMIIBQAIBAQYKKwYBBAGEWQoDATAxMA0GCWCGSAFl
# AwQCAQUABCB83jMyDY36xsW07nbpzC9WgqofY/hTq8jObxbPAZ9BXwIGZiAsyET0
# GBMyMDI0MDQyMzEzMTYxNC4yNzVaMASAAgH0oIHYpIHVMIHSMQswCQYDVQQGEwJV
# UzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UE
# ChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMS0wKwYDVQQLEyRNaWNyb3NvZnQgSXJl
# bGFuZCBPcGVyYXRpb25zIExpbWl0ZWQxJjAkBgNVBAsTHVRoYWxlcyBUU1MgRVNO
# OkQwODItNEJGRC1FRUJBMSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFtcCBT
# ZXJ2aWNloIIReDCCBycwggUPoAMCAQICEzMAAAHcweCMwl9YXo4AAQAAAdwwDQYJ
# KoZIhvcNAQELBQAwfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24x
# EDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlv
# bjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTAwHhcNMjMx
# MDEyMTkwNzA2WhcNMjUwMTEwMTkwNzA2WjCB0jELMAkGA1UEBhMCVVMxEzARBgNV
# BAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jv
# c29mdCBDb3Jwb3JhdGlvbjEtMCsGA1UECxMkTWljcm9zb2Z0IElyZWxhbmQgT3Bl
# cmF0aW9ucyBMaW1pdGVkMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjpEMDgyLTRC
# RkQtRUVCQTElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2VydmljZTCC
# AiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAIvIsyA1sjg9kSKJzelrUWF5
# ShqYWL83amn3SE5JyIVPUC7F6qTcLphhHZ9idf21f0RaGrU8EHydF8NxPMR2KVNi
# AtCGPJa8kV1CGvn3beGB2m2ltmqJanG71mAywrkKATYniwKLPQLJ00EkXw5TSwfm
# JXbdgQLFlHyfA5Kg+pUsJXzqumkIvEr0DXPvptAGqkdFLKwo4BTlEgnvzeTfXukz
# X8vQtTALfVJuTUgRU7zoP/RFWt3WagahZ6UloI0FC8XlBQDVDX5JeMEsx7jgJDdE
# nK44Y8gHuEWRDq+SG9Xo0GIOjiuTWD5uv3vlEmIAyR/7rSFvcLnwAqMdqcy/iqQP
# MlDOcd0AbniP8ia1BQEUnfZT3UxyK9rLB/SRiKPyHDlg8oWwXyiv3+bGB6dmdM61
# ur6nUtfDf51lPcKhK4Vo83pOE1/niWlVnEHQV9NJ5/DbUSqW2RqTUa2O2KuvsyRG
# MEgjGJA12/SqrRqlvE2fiN5ZmZVtqSPWaIasx7a0GB+fdTw+geRn6Mo2S6+/bZEw
# S/0IJ5gcKGinNbfyQ1xrvWXPtXzKOfjkh75iRuXourGVPRqkmz5UYz+R5ybMJWj+
# mfcGqz2hXV8iZnCZDBrrnZivnErCMh5Flfg8496pT0phjUTH2GChHIvE4SDSk2hw
# WP/uHB9gEs8p/9Pe/mt9AgMBAAGjggFJMIIBRTAdBgNVHQ4EFgQU6HPSBd0OfEX3
# uNWsdkSraUGe3dswHwYDVR0jBBgwFoAUn6cVXQBeYl2D9OXSZacbUzUZ6XIwXwYD
# VR0fBFgwVjBUoFKgUIZOaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9j
# cmwvTWljcm9zb2Z0JTIwVGltZS1TdGFtcCUyMFBDQSUyMDIwMTAoMSkuY3JsMGwG
# CCsGAQUFBwEBBGAwXjBcBggrBgEFBQcwAoZQaHR0cDovL3d3dy5taWNyb3NvZnQu
# Y29tL3BraW9wcy9jZXJ0cy9NaWNyb3NvZnQlMjBUaW1lLVN0YW1wJTIwUENBJTIw
# MjAxMCgxKS5jcnQwDAYDVR0TAQH/BAIwADAWBgNVHSUBAf8EDDAKBggrBgEFBQcD
# CDAOBgNVHQ8BAf8EBAMCB4AwDQYJKoZIhvcNAQELBQADggIBANnrb8Ewr8eX/H1s
# Kt3rnwTDx4AqgHbkMNQo+kUGwCINXS3y1GUcdqsK/R1g6Tf7tNx1q0NpKk1JTupU
# JfHdExKtkuhHA+82lT7yISp/Y74dqJ03RCT4Q+8ooQXTMzxiewfErVLt8Wefebnc
# ST0i6ypKv87pCYkxM24bbqbM/V+M5VBppCUs7R+cETiz/zEA1AbZL/viXtHmryA0
# CGd+Pt9c+adsYfm7qe5UMnS0f/YJmEEMkEqGXCzyLK+dh+UsFi0d4lkdcE+Zq5JN
# jIHesX1wztGVAtvX0DYDZdN2WZ1kk+hOMblUV/L8n1YWzhP/5XQnYl03AfXErn+1
# Eatylifzd3ChJ1xuGG76YbWgiRXnDvCiwDqvUJevVRY1qy4y4vlVKaShtbdfgPyG
# eeJ/YcSBONOc0DNTWbjMbL50qeIEC0lHSpL2rRYNVu3hsHzG8n5u5CQajPwx9Pzp
# sZIeFTNHyVF6kujI4Vo9NvO/zF8Ot44IMj4M7UX9Za4QwGf5B71x57OjaX53gxT4
# vzoHvEBXF9qCmHRgXBLbRomJfDn60alzv7dpCVQIuQ062nyIZKnsXxzuKFb0TjXW
# w6OFpG1bsjXpOo5DMHkysribxHor4Yz5dZjVyHANyKo0bSrAlVeihcaG5F74SZT8
# FtyHAW6IgLc5w/3D+R1obDhKZ21WMIIHcTCCBVmgAwIBAgITMwAAABXF52ueAptJ
# mQAAAAAAFTANBgkqhkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgT
# Cldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29m
# dCBDb3Jwb3JhdGlvbjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlmaWNh
# dGUgQXV0aG9yaXR5IDIwMTAwHhcNMjEwOTMwMTgyMjI1WhcNMzAwOTMwMTgzMjI1
# WjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMH
# UmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQD
# Ex1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDCCAiIwDQYJKoZIhvcNAQEB
# BQADggIPADCCAgoCggIBAOThpkzntHIhC3miy9ckeb0O1YLT/e6cBwfSqWxOdcjK
# NVf2AX9sSuDivbk+F2Az/1xPx2b3lVNxWuJ+Slr+uDZnhUYjDLWNE893MsAQGOhg
# fWpSg0S3po5GawcU88V29YZQ3MFEyHFcUTE3oAo4bo3t1w/YJlN8OWECesSq/XJp
# rx2rrPY2vjUmZNqYO7oaezOtgFt+jBAcnVL+tuhiJdxqD89d9P6OU8/W7IVWTe/d
# vI2k45GPsjksUZzpcGkNyjYtcI4xyDUoveO0hyTD4MmPfrVUj9z6BVWYbWg7mka9
# 7aSueik3rMvrg0XnRm7KMtXAhjBcTyziYrLNueKNiOSWrAFKu75xqRdbZ2De+JKR
# Hh09/SDPc31BmkZ1zcRfNN0Sidb9pSB9fvzZnkXftnIv231fgLrbqn427DZM9itu
# qBJR6L8FA6PRc6ZNN3SUHDSCD/AQ8rdHGO2n6Jl8P0zbr17C89XYcz1DTsEzOUyO
# ArxCaC4Q6oRRRuLRvWoYWmEBc8pnol7XKHYC4jMYctenIPDC+hIK12NvDMk2ZItb
# oKaDIV1fMHSRlJTYuVD5C4lh8zYGNRiER9vcG9H9stQcxWv2XFJRXRLbJbqvUAV6
# bMURHXLvjflSxIUXk8A8FdsaN8cIFRg/eKtFtvUeh17aj54WcmnGrnu3tz5q4i6t
# AgMBAAGjggHdMIIB2TASBgkrBgEEAYI3FQEEBQIDAQABMCMGCSsGAQQBgjcVAgQW
# BBQqp1L+ZMSavoKRPEY1Kc8Q/y8E7jAdBgNVHQ4EFgQUn6cVXQBeYl2D9OXSZacb
# UzUZ6XIwXAYDVR0gBFUwUzBRBgwrBgEEAYI3TIN9AQEwQTA/BggrBgEFBQcCARYz
# aHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9Eb2NzL1JlcG9zaXRvcnku
# aHRtMBMGA1UdJQQMMAoGCCsGAQUFBwMIMBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIA
# QwBBMAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB8GA1UdIwQYMBaAFNX2
# VsuP6KJcYmjRPZSQW9fOmhjEMFYGA1UdHwRPME0wS6BJoEeGRWh0dHA6Ly9jcmwu
# bWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3RzL01pY1Jvb0NlckF1dF8yMDEw
# LTA2LTIzLmNybDBaBggrBgEFBQcBAQROMEwwSgYIKwYBBQUHMAKGPmh0dHA6Ly93
# d3cubWljcm9zb2Z0LmNvbS9wa2kvY2VydHMvTWljUm9vQ2VyQXV0XzIwMTAtMDYt
# MjMuY3J0MA0GCSqGSIb3DQEBCwUAA4ICAQCdVX38Kq3hLB9nATEkW+Geckv8qW/q
# XBS2Pk5HZHixBpOXPTEztTnXwnE2P9pkbHzQdTltuw8x5MKP+2zRoZQYIu7pZmc6
# U03dmLq2HnjYNi6cqYJWAAOwBb6J6Gngugnue99qb74py27YP0h1AdkY3m2CDPVt
# I1TkeFN1JFe53Z/zjj3G82jfZfakVqr3lbYoVSfQJL1AoL8ZthISEV09J+BAljis
# 9/kpicO8F7BUhUKz/AyeixmJ5/ALaoHCgRlCGVJ1ijbCHcNhcy4sa3tuPywJeBTp
# kbKpW99Jo3QMvOyRgNI95ko+ZjtPu4b6MhrZlvSP9pEB9s7GdP32THJvEKt1MMU0
# sHrYUP4KWN1APMdUbZ1jdEgssU5HLcEUBHG/ZPkkvnNtyo4JvbMBV0lUZNlz138e
# W0QBjloZkWsNn6Qo3GcZKCS6OEuabvshVGtqRRFHqfG3rsjoiV5PndLQTHa1V1QJ
# sWkBRH58oWFsc/4Ku+xBZj1p/cvBQUl+fpO+y/g75LcVv7TOPqUxUYS8vwLBgqJ7
# Fx0ViY1w/ue10CgaiQuPNtq6TPmb/wrpNPgkNWcr4A245oyZ1uEi6vAnQj0llOZ0
# dFtq0Z4+7X6gMTN9vMvpe784cETRkPHIqzqKOghif9lwY1NNje6CbaUFEMFxBmoQ
# tB1VM1izoXBm8qGCAtQwggI9AgEBMIIBAKGB2KSB1TCB0jELMAkGA1UEBhMCVVMx
# EzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoT
# FU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEtMCsGA1UECxMkTWljcm9zb2Z0IElyZWxh
# bmQgT3BlcmF0aW9ucyBMaW1pdGVkMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjpE
# MDgyLTRCRkQtRUVCQTElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2Vy
# dmljZaIjCgEBMAcGBSsOAwIaAxUAHDn/cz+3yRkIUCJfSbL3djnQEqaggYMwgYCk
# fjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMH
# UmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQD
# Ex1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDANBgkqhkiG9w0BAQUFAAIF
# AOnRQkowIhgPMjAyNDA0MjMwNDA4NDJaGA8yMDI0MDQyNDA0MDg0MlowdDA6Bgor
# BgEEAYRZCgQBMSwwKjAKAgUA6dFCSgIBADAHAgEAAgIUTDAHAgEAAgISBDAKAgUA
# 6dKTygIBADA2BgorBgEEAYRZCgQCMSgwJjAMBgorBgEEAYRZCgMCoAowCAIBAAID
# B6EgoQowCAIBAAIDAYagMA0GCSqGSIb3DQEBBQUAA4GBAKdfQ6krn/9XKU8Iy031
# XFlG85OEXSoh4dBGaqeGlD943dkMdlPnjE+MNokMWYaQ0JNKwtpMkAnPoDcyylCP
# CELlR54i9KaOR7WJp72VKtL04H/EbopdGU86A523FLhAdtVx7+UUaWwr/s7KcbHa
# SrCmgPUrOzaTxyDnHHkwJ3OWMYIEDTCCBAkCAQEwgZMwfDELMAkGA1UEBhMCVVMx
# EzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoT
# FU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUt
# U3RhbXAgUENBIDIwMTACEzMAAAHcweCMwl9YXo4AAQAAAdwwDQYJYIZIAWUDBAIB
# BQCgggFKMBoGCSqGSIb3DQEJAzENBgsqhkiG9w0BCRABBDAvBgkqhkiG9w0BCQQx
# IgQggBzKd+oDWXZxN3wP/sIrTB3PoQe8zLIegp7DhonQxUkwgfoGCyqGSIb3DQEJ
# EAIvMYHqMIHnMIHkMIG9BCBTpxeKatlEP4y8qZzjuWL0Ou0IqxELDhX2TLylxIIN
# NzCBmDCBgKR+MHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAw
# DgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24x
# JjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwAhMzAAAB3MHg
# jMJfWF6OAAEAAAHcMCIEIMlj5Czdui1+yXOeEgNyO7aqtd0QRMsB+0i74NsgRz7z
# MA0GCSqGSIb3DQEBCwUABIICAFrTMdrgy32iWACHT2Lm8uiNOuUH68YsoRfta8V3
# 4HJzJIuxpOgEOlsFIks5GSj1YUi29JlYrFj+6xf6gWWW2BgmqRt0T3mmKuGNQUcf
# CRvIdhkubbup58tShJ+13gIMuCJKOtsWJLeUxLWXXMD3OUXK65Hpym6zXqBZ/Gzh
# LK7fj6Oro7hJmHtGwjGO8UP15ST7ZRtO8DOdA5AGr6I/tnF/aT1gsG8XC/Lh6R9U
# fYrE9rfoVxtcpCErq3zvFmJUsfzHPYLd8MZMQ0OepHjamcLD5bE6JGLtX+YwVsa0
# YSEcRlar3xcB1WLJCHznOX6kBOZT32h6X9f3jY+XEXESrYq+xWZdiYrZM/SbFmCD
# iIt06T978u13ggmt4aojaJRuG2wngIim4T/kYrSB7CXCNU6yrQkQHxrFk81nlDbg
# 7oEAGEtliOHfjIiuILV3xegKT2xuaB+bVdE5QU9Cdjik4JZ4DMLYFt3xIRQZyHRq
# 0J1iz5UMpC6301OXAmVveBRMnlfhETaxitrqsxBcfZPnb8oZDdcwb8UhBq0xNYLk
# An+Zs2UY8Y5/0hz7LXbATTYCA76NnBqRyZKZN2DyjTXYWi8q2Sn3ayjAGhLVrZGi
# e1Jlrpq3HkttbR3Y/7P1kDcD8spLsu2DulpJlajSDg8+RXvrk77N9sLv9IIdGquq
# lI/x
# SIG # End signature block
