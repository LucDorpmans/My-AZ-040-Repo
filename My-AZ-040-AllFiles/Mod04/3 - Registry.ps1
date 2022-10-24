# Demonstration: Managing the registry 

Set-Location HKCU:\Software

Get-ChildItem

New-Item -Name DemoKey

New-ItemProperty -path HKCU:\Software\DemoKey `
    -Name DemoName `
    -Value Test `
    -PropertyType String

Set-Location ..
Get-Item -Path DemoKey
Get-ItemProperty -Path DemoKey

Get-ItemPropertyValue DemoKey -Name DemoName

Set-Location Software\DemoKey

Get-ItemPropertyValue -Name DemoName

Set-Location HKCU:\

Get-ItemPropertyValue HKCU:\SOFTWARE\DemoKey -Name DemoName

<#Cleanup
Remove-ItemProperty -path HKCU:\Software\DemoKey -Name DemoName 
Remove-Item -Path HKCU:\Software\DemoKey
#>