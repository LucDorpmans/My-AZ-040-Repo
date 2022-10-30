# My Settings for Win 1x clients
#
# Hide Edge Chromium FirstRun experience
New-Item HKLM:\SOFTWARE\Policies\Microsoft\Edge
New-ItemProperty -Name HideFirstRunExperience -Path HKLM:\SOFTWARE\Policies\Microsoft\Edge -Value 1

# Get-ItemProperty -Name HideFirstRunExperience -Path HKLM:\SOFTWARE\Policies\Microsoft\Edge 
# Get-ItemPropertyValue -Name HideFirstRunExperience -Path HKLM:\SOFTWARE\Policies\Microsoft\Edge 

# Set WinX CMD not PowerShell for UnActivated Windows 1x clients
# HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\DontUsePowerShellOnWinX
Get-ItemProperty -path  HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
Set-ItemProperty -path  HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name DontUsePowerShellOnWinX -Value 1
Get-Process explorer | Stop-Process

