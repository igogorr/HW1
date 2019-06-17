[CmdletBinding()]
Param (
        [parameter(Mandatory=$false] 
        $zip = 'C:\Temp\Archive.zip',
        [parameter(Mandatory=$false] 
        $Dest = 'C:\Temp\1'
    )
Expand-Archive -Path $zip -DestinationPath $Dest
Get-ChildItem -Path $Dest -Recurse -File | 
Rename-Item -NewName {$_.Directory.Name + $(get-date -f ddmmyy ) + $_.Name}

$sum = Get-ChildItem -Path $Dest -Recurse -File | Measure-Object Length -Sum
Write-Host " Files - "  $sum.Count
Write-host "Size  $Dest - "  ("{0:N2} KB" -f (($sum.Sum)/1KB))