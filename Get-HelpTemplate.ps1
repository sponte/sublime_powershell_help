param(
    [string] $commandName
)

$c = get-command $commandName

$commonParameters = @("Verbose", "Debug", "ErrorAction", "WarningAction", "ErrorVariable", "WarningVariable", "OutVariable", "OutBuffer")

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
        
        Write-Output @"
.PARAMETER $($parameter.Name)

Type $($parameter.ParameterType.FullName)


"@

    }

Write-Output @"
.NOTES
Author: $env:USERNAME
Created: $([DateTime]::Today.ToString("dd MMMM yyyy"))

.EXAMPLE
$($c.Name)

#>
"@
