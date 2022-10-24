# HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\DontUsePowerShellOnWinX
Get-ItemProperty -path  HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
Set-ItemProperty -path  HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name DontUsePowerShellOnWinX -Value 1
Get-Process explorer | Stop-Process
