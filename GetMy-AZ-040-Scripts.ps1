# GetMy-AZ-040-Scripts.ps1
Function Get-MyScript { Param( [string]$AScript,[switch]$EditFile = $False, 
							   [string]$SPath = "$env:USERPROFILE\Downloads\")
			Invoke-Webrequest -Uri "https://raw.githubusercontent.com/LucDorpmans/My-AZ-040-Repo/main/ConfigScripts/$AScript"  -Outfile "$SPath$AScript" 
If ($EditFile) { PSEdit ("$SPath$AScript" )} }

Invoke-WebRequest -uri "https://github.com/LucDorpmans/$MyRepo/archive/refs/heads/main.zip" -OutFile "$env:USERPROFILE\Downloads\$MyRepo.zip"
Expand-Archive "$env:USERPROFILE\Downloads\$MyRepo.zip" -DestinationPath E:\ -Force

# Get-MyScript "PowerShell-Core-7-Download+Install.ps1" 
# Get-MyScript "Edge-HideFirstRunExperience.ps1" -EditFile
# Get-MyScript "WinX-CmdNotPowerShell.ps1" -EditFile
# Get-MyScript "RSAT-W1x-AZ-040.ps1" -EditFile
# Get-MyScript "GitHub-Desktop-Download+SilentInstall.ps1" -EditFile

# WinGet install Microsoft.VisualStudioCode
# WinGet install Microsoft.WindowsTerminal
# WinGet install Microsoft.PowerShell

