$progressPreference='SilentlyContinue'
$PSCVer = "7.3.0"
$MyFile = "PowerShell-$PSCVer-win-x64.msi"
Invoke-Webrequest -Uri "https://github.com/PowerShell/PowerShell/releases/download/v$PSCVer/PowerShell-$PSCVer-win-x64.msi"  -Outfile "$env:USERPROFILE\Downloads\$MyFile"
Get-ChildItem "$env:USERPROFILE\Downloads\$MyFile"
Write-Output "Starting installation of $MyFile"
Start-Process msiexec.exe -Wait -ArgumentList "/i $env:USERPROFILE\Downloads\$MyFile /qn /quiet"
