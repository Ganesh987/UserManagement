
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

# split policy ids into usable parts (only used internally in this file)
function parsePolicyId {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    # the resource Id of a policy definition
    param($resourceId, $typeName)

    # validate args
    if (!$resourceId) {
        throw 'parsePolicyId(resourceId, typeName) argument error: resourceId must be provided.'
    }

    if (!$typeName) {
        # extract typename
        $temp = $resourceId -split '/providers/Microsoft.Authorization/'
        if ($temp.Length -lt 2) {
            throw 'parsePolicy(resourceId, typeName) argument error: resourceId is not a Microsoft.Authorization resource type'
        }

        $typeName = ($temp[1] -split '/')[0]
    }

    if (!$typeName) {
        throw 'parsePolicyId(resourceId, typeName) argument error: unable to find type name.'
    }

    $mark = "/providers/microsoft.authorization/$($typeName)/"
    $parts = $resourceId -split $mark
    $name = ''
    if ($parts.Length -gt 1) {
        $name = $parts[1]
    }

    $scope = $parts[0]
    $subId = ''
    $mgName = ''
    $rgName = ''
    $type = 'none'

    if ($scope -eq '') {
        $type = 'builtin'
    }
    elseif ($scope -like '/providers/Microsoft.Management/managementGroups/*') {
        $type = 'mgname'
        $mgName = ($scope -split '/providers/Microsoft.Management/managementGroups/')[1]
    }
    elseif ($scope -like '/subscriptions/*/resourceGroups/*/*') {
        $type = 'resource'
        $temp = ($scope -split '/subscriptions/')[1]
        $temp = ($temp -split '/resourceGroups/')
        $subId = $temp[0]
        $temp = ($temp[1] -split '/providers/')
        $rgName = $temp[0]
        $resource = $temp[1]
    }
    elseif ($scope -like '/subscriptions/*/resourceGroups/*') {
        $type = 'rgname'
        $temp = ($scope -split '/subscriptions/')[1]
        $temp = ($temp -split '/resourceGroups/')
        $subId = $temp[0]
        $rgName = $temp[1]
    }
    elseif ($scope -like '/subscriptions/*') {
        $type = 'subId'
        $subId = ($scope -split '/subscriptions/')[1]
    }

    return @{
        ScopeType = $type
        SubscriptionId = $subId
        ManagementGroupName = $mgName
        ResourceGroupName = $rgName
        Resource = $resource
        Name = $name
        Scope = $scope
        TypeName = $typeName
    }
}

# split policy definition resourceId into its parts (used externally)
function ParsePolicyDefinitionId {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    # the resource Id of a policy definition
    param($ResourceId)

    parsePolicyId $ResourceId 'policyDefinitions'
}

# split policy set definition resourceId into its parts
function ParsePolicySetDefinitionId {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    # the resource Id of a policy set definition
    param($ResourceId)

    parsePolicyId $ResourceId 'policySetDefinitions'
}

# split policy assignment resourceId into its parts
function ParsePolicyAssignmentId {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    # the resource Id of a policy set definition
    param($ResourceId)

    parsePolicyId $ResourceId 'policyAssignments'
}

# split policy assignment resourceId into its parts
function ParsePolicyExemptionId {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    # the resource Id of a policy set definition
    param($resourceId)

    parsePolicyId $ResourceId 'policyExemptions'
}

# Convert input parameter value to hashtable type expected by the autorest serializers
function ConvertParameterArray
{
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param ($InputObject)

    if ($InputObject -is [array])
    {
        $collection = @(
            foreach ($object in $InputObject) { ConvertParameterArray $object }
        )

        Write-Output -NoEnumerate $collection
    }
    elseif ($InputObject -is [hashtable])
    {
        return $InputObject
    }
    elseif ($InputObject -is [PSObject])
    {
        $hash = @{}

        foreach ($property in $InputObject.PSObject.Properties)
        {
            $hash[$property.Name] = (ConvertParameterArray $property.Value).PSObject.BaseObject
        }

        $hash
    }
    else {
        return $InputObject
    }
}

# convert various input formats to policy-formatted hashtable suitable for autorest serializers
function ConvertParameterObject
{
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param ($InputObject)

    if (!$InputObject)
    {
        return $InputObject
    }
    elseif ($InputObject -is [hashtable])
    {
        # traverse hash table to ensure nested values are all processed
        $returnValue = @{}
        foreach ($key in $InputObject.Keys) {
            $returnValue[$key] = (ConvertParameterObject $InputObject[$key])
        }

        return $returnValue
    }
    elseif ($InputObject -is [array])
    {
        return @{ value = [array](ConvertParameterArray -InputObject $InputObject) }
    }
    elseif ($InputObject -is [PSObject])
    {
        $returnValue = @{}

        foreach ($property in $InputObject.PSObject.Properties) {
            $returnValue[$property.Name] = (ConvertParameterObject $property.Value).PSObject.BaseObject
        }

        return $returnValue
    }
    else {
        return @{ value = $InputObject }
    }
}

# Convert output hashtable object output by autorest serializers to PSCustomObject format for legacy support
function ConvertObjectToPSObject {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param($InputObject)

    if ($null -eq $InputObject) {
        return [PSCustomObject]$null
    }

    if ($InputObject -is [array]) {
        return ,@(foreach ($obj in $InputObject) { ConvertObjectToPSObject $obj })
    }

    if (!$InputObject.ToJsonString) {
        return [PSCustomObject]$InputObject
    }

    $jsonString = $InputObject.ToJsonString()
    if ($jsonString -is [array]) {
        $jsonString = "[$([System.String]::Join(',', $jsonString))]"
    }

    ConvertFrom-Json $jsonString -Depth 100
}

function GetPSObjectProperty {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param (
        [PSObject]$PropertyObject,
        [string]$PropertyPath
    )

    $propertyNames = $PropertyPath.Split('.')
    $tmpObject = $PropertyObject
    foreach ($propertyName in $propertyNames)
    {
        $propertyInfo = $tmpObject.PSObject.Properties[$propertyName]
        if ($propertyInfo)
        {
            if ($propertyInfo.Value -is [PSObject])
            {
                $tmpObject = [PSObject]$propertyInfo.Value
                continue
            }

            return $propertyInfo.Value
        }
    }

    return $tmpObject
}

# tests whether the given string is a Uri
function Test-Uri {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param([string]$Value)

    $uri = ''
    [System.Uri]::TryCreate($Value, [System.UriKind]::Absolute, [ref]$uri)
}

# issues a GET to the given address and returns the contents
function Get-UriContent {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param([string]$UriAddress)

    $response = Invoke-WebRequest $UriAddress -DisableKeepAlive -Method Get
    if ($response.StatusCode -eq 200) {
        return $response.Content
    }
}

# if the given string is a file path or URI, returns the contents of the file or web page
# otherwise returns the original string
function GetFileUriOrStringParameterValue {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param([string]$parameterValue)

    if (Test-Path $parameterValue) {
        Get-Content $parameterValue | Out-String
    }
    else {
        if (Test-Uri $parameterValue) {
            Get-UriContent $parameterValue
        }
        else {
            $parameterValue
        }
    }
}

function ResolvePolicyParameter {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param(
        [string]$ParameterName,
        [string]$ParameterValue,
        [bool]$Debug = $false
    )

    $policy = GetFileUriOrStringParameterValue $ParameterValue
    if ($debug) {
        Write-Host -ForegroundColor Cyan "Parameter ${ParameterName}:" $policy
    }

    $policyParameter = ConvertFrom-Json -Depth 100 -AsHashtable $policy
    if ($policyParameter.properties) {
        return $policyParameter.properties
    } else {
        return $policyParameter
    }
}

function ResolvePolicyMetadataParameter {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param(
        $MetadataValue,
        [bool]$Debug = $false
    )

    if ($metadataValue -is [hashtable]) {
        return $metadataValue
    }

    if ([System.String]::IsNullOrEmpty($metadataValue)) {
        return $metadataValue
    }

    $metadata = (GetFileUriOrStringParameterValue $metadataValue).Trim()
    if ($debug) {
        Write-Host -ForegroundColor Cyan Metadata: $metadata
    }

    if ($metadata -like '@{*') {
        # probably a PSCustomObject, try converting to hashtable
        return (Invoke-Expression($metadata.Replace('=',"='").Replace(';',"';").Replace('}',"'}")))
    }

    # otherwise it should be a JSON string
    if ($metadata -like '{*}') {
        return $metadata | ConvertFrom-Json -Depth 100 -AsHashtable
    }

    throw "Unrecognized metadata format - value: [$($metadataValue)], type: [$($metadataValue.GetType())]"
}

# construct the full Id of a resource given the various parts (only used internally in this file)
function resolvePolicyArtifact {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param(
        [string]$name,
        [string]$subscriptionId,
        [string]$managementGroupName,
        [string]$id,
        [string]$typeName
    )

    $type = 'none'
    $scope = ''
    $scopeType = 'none'
    $scopeName = ''
    $fullScope = ''
    $resourceId = '<invalid>'
    $resourceGroupName = ''

    if ($id -and !$subscriptionId -and !$managementGroupName) {
        $resolved = parsePolicyId $id $typeName
        $fullScope = $resolved.Scope
        $scopeType = $resolved.ScopeType
        switch ($scopeType) {
            'subId' {
                $scope = $resolved.SubscriptionId
                $scopeName = "subscription $($scope)"
                $subscriptionId = $resolved.SubscriptionId
            }
            'mgName' {
                $scope = $resolved.ManagementGroupName
                $scopeName = "management group $($scope)"
                $managementGroupName = $resolved.ManagementGroupName
            }
            'rgname' {
                $scope = $resolved.ResourceGroupName
                $scopeName = "resource group $($scope)"
                $subscriptionId = $resolved.SubscriptionId
                $resourceGroupName = $resolved.ResourceGroupName
            }
            'resource' {
                $scope = $resolved.Resource
                $scopeName = "resource id $($scope)"
                $subscriptionId = $resolved.SubscriptionId
                $resourceGroupName = $resolved.ResourceGroupName
            }
            'none' {
                $scope = $resolved.Scope
                $scopeName = "scope $($scope)"
            }
        }

        $name = $resolved.Name
        $resourceId = $id
    } else {
        if ($name) {
            if ($managementGroupName) {
                $type = 'mgName'
                $scope = $managementGroupName
                $scopeType = 'mgName'
                $scopeName = "management group $($scope)"
                $fullScope = "/providers/Microsoft.Management/managementGroups/$($managementGroupName)"
                $resourceId = "$($fullScope)/providers/Microsoft.Authorization/$($typeName)/$($name)"
            } else {
                if (!$subscriptionId) {
                    $type = 'name'
                    $subscriptionId = (Get-SubscriptionId)
                } else {
                    $type = 'subId'
                }

                $scope = $subscriptionId
                $scopeType = 'subId'
                $scopeName = "subscription $($scope)"
                $fullScope = "/subscriptions/$($subscriptionId)"
                $resourceId = "$($fullScope)/providers/Microsoft.Authorization/$($typeName)/$($name)"
            }
        }
    }

    return @{
        Type = $type;
        Scope = $scope;
        ScopeType = $scopeType
        ScopeName = $scopeName;
        FullScope = $fullScope;
        Name = $name;
        SubscriptionId = $subscriptionId
        ResourceGroupName = $resourceGroupName
        ManagementGroupName = $managementGroupName
        ResourceId = $resourceId
    }
}

function ResolvePolicyDefinition {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param(
        [string]$Name,
        [string]$SubscriptionId,
        [string]$ManagementGroupName,
        [string]$Id
    )

    resolvePolicyArtifact $Name $SubscriptionId $ManagementGroupName $Id 'policyDefinitions'
}

function ResolvePolicySetDefinition {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param(
        [string]$Name,
        [string]$SubscriptionId,
        [string]$ManagementGroupName,
        [string]$Id
    )

    resolvePolicyArtifact $Name $SubscriptionId $ManagementGroupName $Id 'policySetDefinitions'
}

function ResolvePolicyAssignment {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param(
        [string]$Name,
        [string]$Scope,
        [string]$Id
    )

    if ($Id) {
        $resourceId = $Id
    }
    elseif ($Scope) {
        $resourceId = "$($Scope)/providers/Microsoft.Authorization/policyAssignments/$($Name)"
    }
    else {
        $resourceId = "/subscriptions/$($(Get-SubscriptionId))/providers/Microsoft.Authorization/policyAssignments/$($Name)"
    }

    resolvePolicyArtifact $null $null $null $resourceId 'policyAssignments'
}

function ResolvePolicyExemption {
    [Microsoft.Azure.PowerShell.Cmdlets.Policy.DoNotExportAttribute()]
    param(
        [string]$Name,
        [string]$Scope,
        [string]$Id
    )

    if ($Id) {
        $resourceId = $Id
    }
    elseif ($Scope) {
        $resourceId = "$($Scope)/providers/Microsoft.Authorization/policyExemptions/$($Name)"
    }
    else {
        $resourceId = "/subscriptions/$($(Get-SubscriptionId))/providers/Microsoft.Authorization/policyExemptions/$($Name)"
    }

    resolvePolicyArtifact $null $null $null $resourceId 'policyExemptions'
}

function LocationCompleter(
    $commandName,
    $parameterName,
    $wordToComplete,
    $commandAst,
    $fakeBoundParameter
)
{
    if ($global:AzPSPolicyCachedLocations.Count -le 0) {
        $response = Invoke-AzRestMethod -Uri "https://management.azure.com/subscriptions/$($(Get-SubscriptionId))/locations?api-version=2022-12-01" -Method GET
        $global:AzPSPolicyCachedLocations = ($response.Content | ConvertFrom-Json -Depth 100).value | Sort-Object -Property name | Select-Object -ExpandProperty name
    }

    # If you see the following error, it means your context access has expired
    #   The given key 'AzureAttestationServiceEndpointSuffix' was not present in the dictionary.
    $global:AzPSPolicyCachedLocations | Where-Object { $_ -like "$wordToComplete*" }
}

function Get-SubscriptionId {
    $script = Resolve-Path "$PSScriptRoot/../utils/Get-SubscriptionIdTestSafe.ps1"
    return . $script
}

function Get-ExtraParameters
(
    $DefaultProfile,
    $Break,
    $HttpPipelineAppend,
    $HttpPipelinePrepend,
    $Proxy,
    $ProxyCredential,
    $ProxyUseDefaultCredentials
) {
    $parms = @{}
    if ($PSBoundParameters['DefaultProfile']) {
        $parms['DefaultProfile'] = $PSBoundParameters['DefaultProfile']
    }

    if ($PSBoundParameters['Break']) {
        $parms['Break'] = $PSBoundParameters['Break']
    }

    if ($PSBoundParameters['HttpPipelineAppend']) {
        $parms['HttpPipelineAppend'] = $PSBoundParameters['HttpPipelineAppend']
    }

    if ($PSBoundParameters['HttpPipelinePrepend']) {
        $parms['HttpPipelinePrepend'] = $PSBoundParameters['HttpPipelinePrepend']
    }

    if ($PSBoundParameters['Proxy']) {
        $parms['Proxy'] = $PSBoundParameters['Proxy']
    }

    if ($PSBoundParameters['ProxyCredential']) {
        $parms['ProxyCredential'] = $PSBoundParameters['ProxyCredential']
    }

    if ($PSBoundParameters['ProxyUseDefaultCredentials']) {
        $parms['ProxyUseDefaultCredentials'] = $PSBoundParameters['ProxyUseDefaultCredentials']
    }

    return $parms
}

# register the location completer for New-AzPolicyAssignment
Register-ArgumentCompleter -CommandName New-AzPolicyAssignment -ParameterName Location -ScriptBlock ${function:LocationCompleter}

# cache Azure locations to be used by the location completer (Get-AzLocation is not available in this context, need to use REST)
$global:AzPSPolicyCachedLocations = @()
# SIG # Begin signature block
# MIInvgYJKoZIhvcNAQcCoIInrzCCJ6sCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDoOuz20QmpDGDx
# Ze7uX/K8TdbVAmkHgiCetxwZaWMZd6CCDXYwggX0MIID3KADAgECAhMzAAADrzBA
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
# MAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEILJ0q7VVaB3hWzuxL7SYSnqK
# GxYskWVfFQHcGkvQhobyMEIGCisGAQQBgjcCAQwxNDAyoBSAEgBNAGkAYwByAG8A
# cwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20wDQYJKoZIhvcNAQEB
# BQAEggEAaWYoQzjXWfP68JMvLO2I9RCcLoXdXRrlMYXVJqBEhjEIvgCj/6e1FMdL
# jGaN00BN4qx23KpeY2rgx0HL835IiQVTsk0tPe4VyhaGSXLsfMae2nxlz/xcpNRP
# tu5Kg1FX+JZS/sOQ2DitihqupDaFwIbgrUey3Y3T4WzKfaj+58QXykj+Tr/1XDmE
# +vY70sBTDZ8U1kmJICTLYFh487BuoRILTEkwp9aXJhMM1rnZic5Es3e8I8L6odNj
# 6r7lQEU7evrq8Oi7dV3cTrgGburJT3wPOMOfYl4YDmambFETKhwGdBJ52NO99DGT
# W9bHCTqVAfvyj2qtCrmIQWCFwvcQtKGCFygwghckBgorBgEEAYI3AwMBMYIXFDCC
# FxAGCSqGSIb3DQEHAqCCFwEwghb9AgEDMQ8wDQYJYIZIAWUDBAIBBQAwggFYBgsq
# hkiG9w0BCRABBKCCAUcEggFDMIIBPwIBAQYKKwYBBAGEWQoDATAxMA0GCWCGSAFl
# AwQCAQUABCD5mjIF/gHUvtw+EHvIui/fjc8h+dP78HpiQMichkKD3AIGZjOrDSLH
# GBIyMDI0MDUxNjA2NDIxNC4zOFowBIACAfSggdikgdUwgdIxCzAJBgNVBAYTAlVT
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
# 6e/0gjAiGA8yMDI0MDUxNjEwNTcwNloYDzIwMjQwNTE3MTA1NzA2WjB0MDoGCisG
# AQQBhFkKBAExLDAqMAoCBQDp7/SCAgEAMAcCAQACAg1lMAcCAQACAhKjMAoCBQDp
# 8UYCAgEAMDYGCisGAQQBhFkKBAIxKDAmMAwGCisGAQQBhFkKAwKgCjAIAgEAAgMH
# oSChCjAIAgEAAgMBhqAwDQYJKoZIhvcNAQEFBQADgYEAY1zi7fae4heDEc1iRw7Y
# mFJxWStG2Aljb5L/kC8LSmq/zrubLsElO8TALFxPUJuaDsKq0zxmONNfgfPZtEco
# f88NxDWrkKA0qcfW/jzN7SqILXS4vWrrnntNEkvaQIly5ZJgWI1kU+M3wB7sAx9r
# IwI4iedDOrXNVDnx2Ftwc74xggQNMIIECQIBATCBkzB8MQswCQYDVQQGEwJVUzET
# MBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMV
# TWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1T
# dGFtcCBQQ0EgMjAxMAITMwAAAeDU/B8TFR9+XQABAAAB4DANBglghkgBZQMEAgEF
# AKCCAUowGgYJKoZIhvcNAQkDMQ0GCyqGSIb3DQEJEAEEMC8GCSqGSIb3DQEJBDEi
# BCD8GNLOtoHOzUOqAgUBb9UkHbnscLKuq8hVDEkeStnhjzCB+gYLKoZIhvcNAQkQ
# Ai8xgeowgecwgeQwgb0EIOPuUr/yOeVtOM+9zvsMIJJvhNkClj2cmbnCGwr/aQrB
# MIGYMIGApH4wfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAO
# BgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEm
# MCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTACEzMAAAHg1Pwf
# ExUffl0AAQAAAeAwIgQgGa/qE6mR3LjYI9/Wdk/rpMFwa+dnAOF9yQN+IW846bkw
# DQYJKoZIhvcNAQELBQAEggIAM3e1yGOV+6eOaQp8ZiqL7CTRv7eosklkO7eLvGKB
# uGfiYxYTYSS6ua+7W1KfPX5vzveJXHcNkqpUKbtxyokUHnO43jVknOXZObs3/T82
# NM/W/yLcmAxYjaWCwR7K/Z4T9pQowFmEedBcuFsYS44oKJU30jABzcOJFrk1eLq2
# MApR9rUrQ56ogIUhofL7s8FPdS0ZqMvPYL0tY6wNUhb1si2KKZX0xFQHKSsbEFPw
# +zPVOubl9++k/TgTqgCUjbrQQjFnTl7W9tHw5bCd1nqsHKCmQKpoN+OAsEy7e1lr
# /LT8qpoEchiuqjAAbyG29jdioRuh8sob1KPiNExirO4IzPGjIAPEpfU6Z00zp40s
# 5xXInJtCkprEnnDRp4MMuwaSsoiiv9Hvx3S9ksk3xZuS9a4MXOUs+B4tQ7sG6ssP
# jqyZJpdk5OgbTWOqz4vUV9XlvXVJ52TgNvlF1+/ZaIY8s4/Rm2jHrZsJkr5A11TO
# PioteUhmqehgS25rc2oMGKWPS/xmLWHtrt0C9m/Fq6tMLq4HpXeUw8OTFfFTfg/q
# UCWaUK1s39J3L2Zd1H1BbACjNT6Ylg6fZpsBbaCWkKMiFqbDT9LD6nlYWOoESCpi
# sVfPfAAbEMJGFSl5ABQT0qXW1Abf8CneC7WYg58D2rhBxdIr77+OTAxGsRqgxyBb
# lkY=
# SIG # End signature block
