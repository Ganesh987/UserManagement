
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
Download and install kubectl and kubelogin.
.Description
Download and install kubectl and kubelogin.
#>
function Install-AzAksCliTool
{
    [OutputType([System.Boolean])]
    [CmdletBinding(PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Alias("KubectlInstallDestination")]
        [Parameter()]
        [System.String]
        # Path at which to install kubectl. Default to install into ~/.azure-kubectl/
        ${Destination},

        [Alias("KubectlInstallVersion")]
        [Parameter()]
        [System.String]
        # Version of kubectl to install, e.g. 'v1.17.2'. Default value: Latest.
        ${Version},
    
        [Alias("KubectlDownloadFromMirror")]
        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        # Download from mirror site : https://mirror.azure.cn/kubernetes/kubectl/
        ${DownloadFromMirror},

        [Parameter()]
        [System.String]
        # Path at which to install kubectl. Default to install into ~/.azure-kubelogin/
        ${KubeloginInstallDestination},

        [Parameter()]
        [System.String]
        # Version of kubectl to install, e.g. 'v0.0.20'. Default value: Latest
        ${KubeloginInstallVersion},
    
        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        # Download from mirror site : https://mirror.azure.cn/kubernetes/kubelogin
        ${KubeloginDownloadFromMirror},
    
        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        # Wait for .NET debugger to attach
        ${PassThru},
    
        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        # Run cmdlet in the background
        ${AsJob},
    
        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        # Overwrite existing kubectl and kubelogin without prompt
        ${Force}
    )
    
    process
    {
        #Region Install kubectl
        $KubectlParams = @{}
        If ($PSBoundParameters.ContainsKey("Destination"))
        {
            $KubectlParams["Destination"] = $PSBoundParameters["Destination"]
        }
        If ($PSBoundParameters.ContainsKey("Version"))
        {
            $KubectlParams["Version"] = $PSBoundParameters["Version"]
        }
        If ($PSBoundParameters.ContainsKey("DownloadFromMirror"))
        {
            $KubectlParams["DownloadFromMirror"] = $PSBoundParameters["DownloadFromMirror"]
        }
        If ($PSBoundParameters.ContainsKey("Force"))
        {
            $KubectlParams["Force"] = $PSBoundParameters["Force"]
        }
        Install-Kubectl @KubectlParams
        #EndRegion

        #Region Install kubelogin
        $KubeloginParams = @{}
        If ($PSBoundParameters.ContainsKey("KubeloginInstallDestination"))
        {
            $KubeloginParams["Destination"] = $PSBoundParameters["KubeloginInstallDestination"]
        }
        If ($PSBoundParameters.ContainsKey("KubeloginInstallVersion"))
        {
            $KubeloginParams["Version"] = $PSBoundParameters["KubeloginInstallVersion"]
        }
        If ($PSBoundParameters.ContainsKey("KubeloginDownloadFromMirror"))
        {
            $KubeloginParams["DownloadFromMirror"] = $PSBoundParameters["KubeloginDownloadFromMirror"]
        }
        If ($PSBoundParameters.ContainsKey("Force"))
        {
            $KubeloginParams["Force"] = $PSBoundParameters["Force"]
        }
        Install-Kubelogin @KubeloginParams
        #EndRegion
    }
}

function IsWindows {
    [Microsoft.Azure.PowerShell.Cmdlets.Aks.DoNotExportAttribute()]
    param(
    )
    process {
        return (Get-OSName).contains("Windows")
    }
}

function Get-OSName {
    [Microsoft.Azure.PowerShell.Cmdlets.Aks.DoNotExportAttribute()]
    param(
    )
    process {
        if ($PSVersionTable.PSEdition.Contains("Core")) {
            $OSPlatform = $PSVersionTable.OS
        } else {
            $OSPlatform = $env:OS
        }
        return $OSPlatform
    }
}
Function Install-Kubectl
{
    [Microsoft.Azure.PowerShell.Cmdlets.Aks.DoNotExportAttribute()]
    [CmdletBinding(PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter()]
        [System.String]
        ${Destination},

        [Parameter()]
        [System.String]
        ${Version},
    
        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        ${DownloadFromMirror},
    
        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        ${Force}
    )

    Process
    {
        $baseUrl = "https://storage.googleapis.com/kubernetes-release/release"
        If ($DownloadFromMirror)
        {
            $baseUrl = "https://mirror.azure.cn/kubernetes/kubectl"
        }
        If (($Null -Eq $Destination) -or ("" -Eq $Destination))
        {
            $Destination = [System.IO.Path]::Combine($env:USERPROFILE, ".azure-kubectl")
        }
        If (-not (Test-Path -Path $Destination))
        {
            New-Item -Path $Destination -ItemType Directory
        }
        $Destination = Resolve-Path -Path $Destination

        If (($Null -Eq $Version) -or ("" -Eq $Version))
        {
            $url = "$baseUrl/stable.txt"
            $Version = (Invoke-WebRequest -Uri $url).Content.Trim()
        }
        If (IsWindows)
        {
            $destFilePath = [System.IO.Path]::Combine($Destination, "kubectl.exe")
            $downloadFileUrl = "$baseUrl/$Version/bin/windows/amd64/kubectl.exe"
        }
        ElseIf ($IsLinux)
        {
            $destFilePath = [System.IO.Path]::Combine($Destination, "kubectl")
            $downloadFileUrl = "$baseUrl/$Version/bin/linux/amd64/kubectl"
        }
        ElseIf ($IsMacOS)
        {
            $destFilePath = [System.IO.Path]::Combine($Destination, "kubectl")
            $downloadFileUrl = "$baseUrl/$Version/bin/darwin/amd64/kubectl"
        }
        Else
        {
            $message = "Sorry, this cmdlet is not supported in current OS."
            $ex = [System.PlatformNotSupportedException]::New($message)
            $ex.Data[[Microsoft.Azure.Commands.Common.AzurePSErrorDataKeys]::ErrorKindKey] = [Microsoft.Azure.Commands.Common.ErrorKind]::UserError
            $ex.Data[[Microsoft.Azure.Commands.Common.AzurePSErrorDataKeys]::DesensitizedErrorMessageKey] = $message
            throw $ex
        }
        #region download and install
        If ($PSCmdlet.ShouldProcess("Downloading kubectl from internet.", $destFilePath))
        {
            If (Test-Path -Path $destFilePath)
            {
                If ($Force -Or $PSCmdlet.ShouldContinue("File $destFilePath exist, are you want to replace it?", "Replace file"))
                {
                    $tmpFilePath = "$destFilePath.tmp"
                    Write-Verbose "Downloading from $downloadFileUrl to local: $tmpFilePath"
                    Invoke-WebRequest -Uri $downloadFileUrl -OutFile $tmpFilePath
                    Write-Verbose "Deleting $destFilePath"
                    Remove-Item -Path $destFilePath
                    Write-Verbose "Moving $tmpFilePath to $destFilePath"
                    Move-Item -Path $tmpFilePath -Destination $destFilePath
                }
            }
            Else
            {
                Write-Verbose "Downloading from $downloadFileUrl to local: $destFilePath"
                Invoke-WebRequest -Uri $downloadFileUrl -OutFile $destFilePath
            }
        }
        #endregion
    }
}

Function Install-Kubelogin
{
    [Microsoft.Azure.PowerShell.Cmdlets.Aks.DoNotExportAttribute()]
    [CmdletBinding(PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter()]
        [System.String]
        ${Destination},

        [Parameter()]
        [System.String]
        ${Version},
    
        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        ${DownloadFromMirror},
    
        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        ${Force}
    )

    Process
    {
        $baseDownloadUrl = "https://github.com/Azure/kubelogin/releases/download"
        $latestReleaseUrl = "https://api.github.com/repos/Azure/kubelogin/releases/latest"
        If ($DownloadFromMirror)
        {
            $baseDownloadUrl = "https://mirror.azure.cn/kubernetes/kubelogin"
            $latestReleaseUrl = "https://mirror.azure.cn/kubernetes/kubelogin/latest"
        }
        If (($Null -Eq $Destination) -or ("" -Eq $Destination))
        {
            $Destination = [System.IO.Path]::Combine($env:USERPROFILE, ".azure-kubelogin")
        }
        If (-not (Test-Path -Path $Destination))
        {
            New-Item -Path $Destination -ItemType Directory
        }
        $Destination = Resolve-Path -Path $Destination
        If (($Null -Eq $Version) -or ("" -Eq $Version))
        {
            $latestVersionInfo = (Invoke-WebRequest -Uri $latestReleaseUrl).Content | ConvertFrom-Json
            $Version = $latestVersionInfo.tag_name.Trim()
        }
        $downloadFileUrl = "$baseDownloadUrl/$Version/kubelogin.zip"
        If (IsWindows)
        {
            $subDir = "windows_amd64"
            $binaryName = "kubelogin.exe"
            $destFilePath = [System.IO.Path]::Combine($Destination, "kubelogin.exe")
        }
        ElseIf ($IsLinux)
        {
            $subDir = "linux_amd64"
            $binaryName = "kubelogin"
            $destFilePath = [System.IO.Path]::Combine($Destination, "kubelogin")
        }
        ElseIf ($IsMacOS)
        {
            If ($Env:PROCESSOR_ARCHITECTURE -Eq "AMD64")
            {
                $subDir = "darwin_amd64"
            }
            Else
            {
                $subDir = "darwin_arm64"
            }
            $binaryName = "kubelogin"
            $destFilePath = [System.IO.Path]::Combine($Destination, "kubelogin")
        }
        Else
        {
            $message = "Sorry, this cmdlet is not supported in current OS."
            $ex = [System.PlatformNotSupportedException]::New($message)
            $ex.Data[[Microsoft.Azure.Commands.Common.AzurePSErrorDataKeys]::ErrorKindKey] = [Microsoft.Azure.Commands.Common.ErrorKind]::UserError
            $ex.Data[[Microsoft.Azure.Commands.Common.AzurePSErrorDataKeys]::DesensitizedErrorMessageKey] = $message
            throw $ex
        }
        
        #region download and install
        If ($PSCmdlet.ShouldProcess("Downloading kubelogin from internet.", $destFilePath))
        {
            $downloadFilePath = [System.IO.Path]::Combine($Destination, "kubelogin.zip")
            $uncompressFolderPath = [System.IO.Path]::Combine($Destination, "kubelogin-folder")
            $binFilePath = [System.IO.Path]::Combine($uncompressFolderPath, "bin", $subDir, $binaryName)
            $shouldDownload = $true
            If (Test-Path -Path $destFilePath)
            {
                If ($Force -Or $PSCmdlet.ShouldContinue("File $destFilePath exist, are you want to replace it?", "Replace file"))
                {
                    Write-Verbose "Deleting $destFilePath"
                    Remove-Item -Path $destFilePath
                }
                Else
                {
                    $shouldDownload = $false
                }
            }
            If ($shouldDownload)
            {
                Write-Verbose "Downloading from $downloadFileUrl to local: $downloadFilePath"
                Invoke-WebRequest -Uri $downloadFileUrl -OutFile $downloadFilePath
                Expand-Archive $downloadFilePath -DestinationPath $uncompressFolderPath -Force
                Write-Verbose "Deleting $destFilePath"
                Move-Item -Path $binFilePath -Destination $destFilePath
                Write-Verbose "Deleting $downloadFilePath"
                Remove-Item $downloadFilePath
                Write-Verbose "Deleting $uncompressFolderPath"
                Remove-Item $uncompressFolderPath -Recurse
            }
        }
        #endregion
    }
}

# SIG # Begin signature block
# MIInvgYJKoZIhvcNAQcCoIInrzCCJ6sCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCA442MKWqPKoI7z
# 19Uv47rzRJ8/QAZnDIpaF+6hiHx7hKCCDXYwggX0MIID3KADAgECAhMzAAADrzBA
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
# /Xmfwb1tbWrJUnMTDXpQzTGCGZ4wghmaAgEBMIGVMH4xCzAJBgNVBAYTAlVTMRMw
# EQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVN
# aWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNp
# Z25pbmcgUENBIDIwMTECEzMAAAOvMEAOTKNNBUEAAAAAA68wDQYJYIZIAWUDBAIB
# BQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEO
# MAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEIALRgLG8wnY9O5zgHSunIqpY
# zEJAIHGdyUeQo37Bts9oMEIGCisGAQQBgjcCAQwxNDAyoBSAEgBNAGkAYwByAG8A
# cwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20wDQYJKoZIhvcNAQEB
# BQAEggEAUCJuxdVJFMtNfKbOl1fQJUD4MG9qvY/mwEl32jLgpSbCfQ5Zj2t/HXHt
# oYtPpDtzba0X1sxLWGNZhHFm50OFQbgcRRCvN6dDiqlZCKR3A3u5L3sQOTWrR3tg
# 1b3zANActWtP0L8uaPocNtMX//gjyhH/HgPgTQL/9b+Dl3GLQIvKpeCapRDurlca
# aoKwd9nUgt+AjmABpWcsRqVS5gN29UsRxZC1I6h7BTu4XwPymTgWmv+ACcU88O5B
# uOsaeQyME00NJd/yNDbDE1wz8g0tyaJ26B6BxfOzCwT2IgamOg7mlcgM6AT8qrH9
# cFZpzWgWCaiKHas3nygbUVbQS0bTh6GCFygwghckBgorBgEEAYI3AwMBMYIXFDCC
# FxAGCSqGSIb3DQEHAqCCFwEwghb9AgEDMQ8wDQYJYIZIAWUDBAIBBQAwggFYBgsq
# hkiG9w0BCRABBKCCAUcEggFDMIIBPwIBAQYKKwYBBAGEWQoDATAxMA0GCWCGSAFl
# AwQCAQUABCCxvA1sSGmY/bae0Jv1td2gQI7rOyXxuY5RmIUivI5w1QIGZh/eWJ7b
# GBIyMDI0MDQyMzEzMTYxMy43NlowBIACAfSggdikgdUwgdIxCzAJBgNVBAYTAlVT
# MRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQK
# ExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xLTArBgNVBAsTJE1pY3Jvc29mdCBJcmVs
# YW5kIE9wZXJhdGlvbnMgTGltaXRlZDEmMCQGA1UECxMdVGhhbGVzIFRTUyBFU046
# MTc5RS00QkIwLTgyNDYxJTAjBgNVBAMTHE1pY3Jvc29mdCBUaW1lLVN0YW1wIFNl
# cnZpY2WgghF4MIIHJzCCBQ+gAwIBAgITMwAAAeDU/B8TFR9+XQABAAAB4DANBgkq
# hkiG9w0BAQsFADB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQ
# MA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9u
# MSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDAeFw0yMzEw
# MTIxOTA3MTlaFw0yNTAxMTAxOTA3MTlaMIHSMQswCQYDVQQGEwJVUzETMBEGA1UE
# CBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9z
# b2Z0IENvcnBvcmF0aW9uMS0wKwYDVQQLEyRNaWNyb3NvZnQgSXJlbGFuZCBPcGVy
# YXRpb25zIExpbWl0ZWQxJjAkBgNVBAsTHVRoYWxlcyBUU1MgRVNOOjE3OUUtNEJC
# MC04MjQ2MSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFtcCBTZXJ2aWNlMIIC
# IjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEArIec86HFu9EBOcaNv/p+4GGH
# dkvOi0DECB0tpn/OREVR15IrPI23e2qiswrsYO9xd0qz6ogxRu96eUf7Dneyw9rq
# tg/vrRm4WsAGt+x6t/SQVrI1dXPBPuNqsk4SOcUwGn7KL67BDZOcm7FzNx4bkUMe
# sgjqwXoXzv2U/rJ1jQEFmRn23f17+y81GJ4DmBSe/9hwz9sgxj9BiZ30XQH55sVi
# L48fgCRdqE2QWArzk4hpGsMa+GfE5r/nMYvs6KKLv4n39AeR0kaV+dF9tDdBcz/n
# +6YE4obgmgVjWeJnlFUfk9PT64KPByqFNue9S18r437IHZv2sRm+nZO/hnBjMR30
# D1Wxgy5mIJJtoUyTvsvBVuSWmfDhodYlcmQRiYm/FFtxOETwVDI6hWRK4pzk5Znb
# 5Yz+PnShuUDS0JTncBq69Q5lGhAGHz2ccr6bmk5cpd1gwn5x64tgXyHnL9xctAw6
# aosnPmXswuobBTTMdX4wQ7wvUWjbMQRDiIvgFfxiScpeiccZBpxIJotmi3aTIlVG
# wVLGfQ+U+8dWnRh2wIzN16LD2MBnsr2zVbGxkYQGsr+huKlfq7GMSnJQD2ZtU+WO
# VvdHgxYjQTbEj80zoXgBzwJ5rHdhYtP5pYJl6qIgwvHLJZmD6LUpjxkTMx41MoIQ
# jnAXXDGqvpPX8xCj7y0CAwEAAaOCAUkwggFFMB0GA1UdDgQWBBRwXhc/bp1X7xK6
# ygDVddDZMNKZ0jAfBgNVHSMEGDAWgBSfpxVdAF5iXYP05dJlpxtTNRnpcjBfBgNV
# HR8EWDBWMFSgUqBQhk5odHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2Ny
# bC9NaWNyb3NvZnQlMjBUaW1lLVN0YW1wJTIwUENBJTIwMjAxMCgxKS5jcmwwbAYI
# KwYBBQUHAQEEYDBeMFwGCCsGAQUFBzAChlBodHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20vcGtpb3BzL2NlcnRzL01pY3Jvc29mdCUyMFRpbWUtU3RhbXAlMjBQQ0ElMjAy
# MDEwKDEpLmNydDAMBgNVHRMBAf8EAjAAMBYGA1UdJQEB/wQMMAoGCCsGAQUFBwMI
# MA4GA1UdDwEB/wQEAwIHgDANBgkqhkiG9w0BAQsFAAOCAgEAwBPODpH8DSV07syo
# bEPVUmOLnJUDWEdvQdzRiO2/taTFDyLB9+W6VflSzri0Pf7c1PUmSmFbNoBZ/bAp
# 0DDflHG1AbWI43ccRnRfbed17gqD9Z9vHmsQeRn1vMqdH/Y3kDXr7D/WlvAnN19F
# yclPdwvJrCv+RiMxZ3rc4/QaWrvS5rhZQT8+jmlTutBFtYShCjNjbiECo5zC5Fyb
# oJvQkF5M4J5EGe0QqCMp6nilFpC3tv2+6xP3tZ4lx9pWiyaY+2xmxrCCekiNsFrn
# m0d+6TS8ORm1sheNTiavl2ez12dqcF0FLY9jc3eEh8I8Q6zOq7AcuR+QVn/1vHDz
# 95EmV22i6QejXpp8T8Co/+yaYYmHllHSmaBbpBxf7rWt2LmQMlPMIVqgzJjNRLRI
# RvKsNn+nYo64oBg2eCWOI6WWVy3S4lXPZqB9zMaOOwqLYBLVZpe86GBk2YbDjZIU
# HWpqWhrwpq7H1DYccsTyB57/muA6fH3NJt9VRzshxE2h2rpHu/5HP4/pcq06DIKp
# b/6uE+an+fsWrYEZNGRzL/+GZLfanqrKCWvYrg6gkMlfEWzqXBzwPzqqVR4aNTKj
# uFXLlW/ID7LSYacQC4Dzm2w5xQ+XPBYXmy/4Hl/Pfk5bdfhKmTlKI26WcsVE8zlc
# KxIeq9xsLxHerCPbDV68+FnEO40wggdxMIIFWaADAgECAhMzAAAAFcXna54Cm0mZ
# AAAAAAAVMA0GCSqGSIb3DQEBCwUAMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMK
# V2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0
# IENvcnBvcmF0aW9uMTIwMAYDVQQDEylNaWNyb3NvZnQgUm9vdCBDZXJ0aWZpY2F0
# ZSBBdXRob3JpdHkgMjAxMDAeFw0yMTA5MzAxODIyMjVaFw0zMDA5MzAxODMyMjVa
# MHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdS
# ZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMT
# HU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwMIICIjANBgkqhkiG9w0BAQEF
# AAOCAg8AMIICCgKCAgEA5OGmTOe0ciELeaLL1yR5vQ7VgtP97pwHB9KpbE51yMo1
# V/YBf2xK4OK9uT4XYDP/XE/HZveVU3Fa4n5KWv64NmeFRiMMtY0Tz3cywBAY6GB9
# alKDRLemjkZrBxTzxXb1hlDcwUTIcVxRMTegCjhuje3XD9gmU3w5YQJ6xKr9cmmv
# Haus9ja+NSZk2pg7uhp7M62AW36MEBydUv626GIl3GoPz130/o5Tz9bshVZN7928
# jaTjkY+yOSxRnOlwaQ3KNi1wjjHINSi947SHJMPgyY9+tVSP3PoFVZhtaDuaRr3t
# pK56KTesy+uDRedGbsoy1cCGMFxPLOJiss254o2I5JasAUq7vnGpF1tnYN74kpEe
# HT39IM9zfUGaRnXNxF803RKJ1v2lIH1+/NmeRd+2ci/bfV+AutuqfjbsNkz2K26o
# ElHovwUDo9Fzpk03dJQcNIIP8BDyt0cY7afomXw/TNuvXsLz1dhzPUNOwTM5TI4C
# vEJoLhDqhFFG4tG9ahhaYQFzymeiXtcodgLiMxhy16cg8ML6EgrXY28MyTZki1ug
# poMhXV8wdJGUlNi5UPkLiWHzNgY1GIRH29wb0f2y1BzFa/ZcUlFdEtsluq9QBXps
# xREdcu+N+VLEhReTwDwV2xo3xwgVGD94q0W29R6HXtqPnhZyacaue7e3PmriLq0C
# AwEAAaOCAd0wggHZMBIGCSsGAQQBgjcVAQQFAgMBAAEwIwYJKwYBBAGCNxUCBBYE
# FCqnUv5kxJq+gpE8RjUpzxD/LwTuMB0GA1UdDgQWBBSfpxVdAF5iXYP05dJlpxtT
# NRnpcjBcBgNVHSAEVTBTMFEGDCsGAQQBgjdMg30BATBBMD8GCCsGAQUFBwIBFjNo
# dHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL0RvY3MvUmVwb3NpdG9yeS5o
# dG0wEwYDVR0lBAwwCgYIKwYBBQUHAwgwGQYJKwYBBAGCNxQCBAweCgBTAHUAYgBD
# AEEwCwYDVR0PBAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wHwYDVR0jBBgwFoAU1fZW
# y4/oolxiaNE9lJBb186aGMQwVgYDVR0fBE8wTTBLoEmgR4ZFaHR0cDovL2NybC5t
# aWNyb3NvZnQuY29tL3BraS9jcmwvcHJvZHVjdHMvTWljUm9vQ2VyQXV0XzIwMTAt
# MDYtMjMuY3JsMFoGCCsGAQUFBwEBBE4wTDBKBggrBgEFBQcwAoY+aHR0cDovL3d3
# dy5taWNyb3NvZnQuY29tL3BraS9jZXJ0cy9NaWNSb29DZXJBdXRfMjAxMC0wNi0y
# My5jcnQwDQYJKoZIhvcNAQELBQADggIBAJ1VffwqreEsH2cBMSRb4Z5yS/ypb+pc
# FLY+TkdkeLEGk5c9MTO1OdfCcTY/2mRsfNB1OW27DzHkwo/7bNGhlBgi7ulmZzpT
# Td2YurYeeNg2LpypglYAA7AFvonoaeC6Ce5732pvvinLbtg/SHUB2RjebYIM9W0j
# VOR4U3UkV7ndn/OOPcbzaN9l9qRWqveVtihVJ9AkvUCgvxm2EhIRXT0n4ECWOKz3
# +SmJw7wXsFSFQrP8DJ6LGYnn8AtqgcKBGUIZUnWKNsIdw2FzLixre24/LAl4FOmR
# sqlb30mjdAy87JGA0j3mSj5mO0+7hvoyGtmW9I/2kQH2zsZ0/fZMcm8Qq3UwxTSw
# ethQ/gpY3UA8x1RtnWN0SCyxTkctwRQEcb9k+SS+c23Kjgm9swFXSVRk2XPXfx5b
# RAGOWhmRaw2fpCjcZxkoJLo4S5pu+yFUa2pFEUep8beuyOiJXk+d0tBMdrVXVAmx
# aQFEfnyhYWxz/gq77EFmPWn9y8FBSX5+k77L+DvktxW/tM4+pTFRhLy/AsGConsX
# HRWJjXD+57XQKBqJC4822rpM+Zv/Cuk0+CQ1ZyvgDbjmjJnW4SLq8CdCPSWU5nR0
# W2rRnj7tfqAxM328y+l7vzhwRNGQ8cirOoo6CGJ/2XBjU02N7oJtpQUQwXEGahC0
# HVUzWLOhcGbyoYIC1DCCAj0CAQEwggEAoYHYpIHVMIHSMQswCQYDVQQGEwJVUzET
# MBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMV
# TWljcm9zb2Z0IENvcnBvcmF0aW9uMS0wKwYDVQQLEyRNaWNyb3NvZnQgSXJlbGFu
# ZCBPcGVyYXRpb25zIExpbWl0ZWQxJjAkBgNVBAsTHVRoYWxlcyBUU1MgRVNOOjE3
# OUUtNEJCMC04MjQ2MSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFtcCBTZXJ2
# aWNloiMKAQEwBwYFKw4DAhoDFQBt89HV8FfofFh/I/HzNjMlTl8hDKCBgzCBgKR+
# MHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdS
# ZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMT
# HU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwMA0GCSqGSIb3DQEBBQUAAgUA
# 6dGclTAiGA8yMDI0MDQyMzEwMzM1N1oYDzIwMjQwNDI0MTAzMzU3WjB0MDoGCisG
# AQQBhFkKBAExLDAqMAoCBQDp0ZyVAgEAMAcCAQACAhdaMAcCAQACAhKNMAoCBQDp
# 0u4VAgEAMDYGCisGAQQBhFkKBAIxKDAmMAwGCisGAQQBhFkKAwKgCjAIAgEAAgMH
# oSChCjAIAgEAAgMBhqAwDQYJKoZIhvcNAQEFBQADgYEAA94zIZ/dh3L6OpC+zrdc
# JlpZjtrnoGzAdy13pOTwCSVbBlBUr0z6FcKkPIE/TmF3mB1ZV/noc4/xLACzz0Xz
# eQRPR/4CZ62T46by6bPY8jiiSW4a5eDt5GwnSKI0w+DtaBDxCLtUxemlOgS90XDJ
# jAGa1wGk38aRzvxoBiiYeJMxggQNMIIECQIBATCBkzB8MQswCQYDVQQGEwJVUzET
# MBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMV
# TWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1T
# dGFtcCBQQ0EgMjAxMAITMwAAAeDU/B8TFR9+XQABAAAB4DANBglghkgBZQMEAgEF
# AKCCAUowGgYJKoZIhvcNAQkDMQ0GCyqGSIb3DQEJEAEEMC8GCSqGSIb3DQEJBDEi
# BCA0y8uBkeKeqkAxLyogFer5AGK37B0wqOBfmDbHOFFCujCB+gYLKoZIhvcNAQkQ
# Ai8xgeowgecwgeQwgb0EIOPuUr/yOeVtOM+9zvsMIJJvhNkClj2cmbnCGwr/aQrB
# MIGYMIGApH4wfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAO
# BgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEm
# MCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTACEzMAAAHg1Pwf
# ExUffl0AAQAAAeAwIgQgjngA/aHtWHuj4P/eMa/zTx4pnwusYeBD6rkq2ptrMUEw
# DQYJKoZIhvcNAQELBQAEggIAC4qucnK5MmtcUe20NCjsLPqmdoUSEcTaAsrRwGPU
# aVZfDEX/AYXHSwxKNagaIHoyMDktLnXFdzoRTFaNRfv74oJC9HJr/MwvV0yJ7qlo
# n8E6krDXewjzS6zX2NDVU47BQTRbEXf6p6KBb1et/Wl3fba0JUOY2e+A0rRkUPX3
# M6uhb681qR9Xn25enVmRP1cA3s6Vn65fzR9Jb40cCJUAs86upPPnM5jDpN5azaVg
# tCreMfblacwSfFURuWUaCPYxshqMiDt6dFeovsCeWcWbgzTm+ZvQCD0ARWJiEjWC
# mVqKzPueVcZOj5DdQuncV9E4Qx7DeiAELyT5l966APD5HLj02ilUMCHRIuY03hrm
# 0kvBc9z8rvHvkBn16OUGNrmsx3V9ZuAFKpFZ05UhWmvyprnBe1S730GFbKvYPaVg
# zR7/WGHxm0RvE/7iPhZ6vKv/h2X2ElTh+qxerxlbR0RJH688NEHgQiScS0ZwkBzx
# JHbLHzNSpRcJhVLMg5FqY3R3T/XsUCR2XPYjDPKAgoEVA1HxgwHwNknZu+cKgCQX
# grbbsRJJYG+wqzG8Od+Gsua2st4gpSWyObTebq0xJ15kcDaCvVlGM3h/z0ZBY6/S
# V96JkabvH1ZNetqYYV/K/bl6aL/PhcFUC/SY1W++LhgZbrX9+lcJhBHLvTPVrO7O
# mBE=
# SIG # End signature block
