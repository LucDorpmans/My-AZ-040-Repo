# Demonstration: Obtaining user input by using parameters

<#
Set-Location E:\Mod07\Democode # Original
Set-Location F:\Mod07 # My location

Rename-Item .\Mod07_Demo02.txt -NewName Demo02.ps1

.\Demo02.ps1

.\Demo02.ps1 LON-DC1 300

.\Demo02.ps1 -EventID 300 -ComputerName LON-DC1

PsEdit .\Demo02.ps1

#>

Param (
    [string]$ComputerName,
    [int]$EventID
)

Write-Host "The value of `$ComputerName is: $ComputerName" # =(Read-Host 'Enter computer name')
Write-Host "The value of `$EventID is: $EventID" # =300
