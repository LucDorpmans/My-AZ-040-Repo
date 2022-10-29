# Hide Edge Chromium FirstRun experience
New-Item HKLM:\SOFTWARE\Policies\Microsoft\Edge
New-ItemProperty -Name HideFirstRunExperience -Path HKLM:\SOFTWARE\Policies\Microsoft\Edge -Value 1

Get-ItemProperty -Name HideFirstRunExperience -Path HKLM:\SOFTWARE\Policies\Microsoft\Edge 
Get-ItemPropertyValue -Name HideFirstRunExperience -Path HKLM:\SOFTWARE\Policies\Microsoft\Edge 

