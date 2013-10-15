param(
    [string] $commandName
)

$c = get-command $commandName

$commonParameters = @("Verbose", "Debug", "ErrorAction", "WarningAction", "ErrorVariable", "WarningVariable", "OutVariable", "OutBuffer", "WhatIf")
$parameters = @()

Write-Output @"
<#
.SYNOPSIS


.DESCRIPTION


"@

$c.Parameters.Keys | %{
    if($commonParameters -contains $_) {
        return
    }
    $parameter = $c.Parameters[$_]
    $parameters += $c.Parameters[$_]
    
    Write-Output @"
.PARAMETER $($parameter.Name)


"@

}

$parametersString = $parameters | %{
    $name = $_.Name
    # $value = New-Object ($_.ParameterType.FullName)

    "-$($_.Name) "
}

Write-Output @"
.NOTES
Author: $env:USERNAME
Created: $([DateTime]::Today.ToString("dd MMMM yyyy"))

.EXAMPLE
$($c.Name) $parametersString

#>
"@
