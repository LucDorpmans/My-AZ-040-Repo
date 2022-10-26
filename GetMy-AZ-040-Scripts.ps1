# GetMy-AZ-040-Scripts.ps1
Function Get-MyScript { Param( [string]$AScript,[switch]$EditFile = $False, 
							   [string]$SPath = "$env:USERPROFILE\Downloads\")
			Invoke-Webrequest -Uri "https://raw.githubusercontent.com/LucDorpmans/My-AZ-040-Repo/main/$AScript"  -Outfile "$SPath$AScript" 
If ($EditFile) { PSEdit ("$SPath$AScript" )} }

Get-MyScript "PowerShell-Core-7-Download+Install.ps1" -EditFile
Get-MyScript "Edge-HideFirstRunExperience.ps1" -EditFile
Get-MyScript "WinX-CmdNotPowerShell.ps1" -EditFile
Get-MyScript "AddRSATToolsList-Win1x.ps1" -EditFile
Get-MyScript "GitHub-Desktop-Download+SilentInstall.ps1" -EditFile

# WinGet install Microsoft.VisualStudioCode
# Get the Install-VSCode script"
# Invoke-Webrequest -Uri "https://raw.githubusercontent.com/PowerShell/vscode-powershell/master/scripts/Install-VSCode.ps1" -Outfile "$env:USERPROFILE\Downloads\Install-VSCode.ps1"
# PSEdit  ("$env:USERPROFILE\Downloads\Install-VSCode.ps1")
