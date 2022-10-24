# Demonstration: Obtaining user input by using parameters

<#
Set-Location E:\Mod09\Democode # Original
Set-Location F:\10961C-ENU-Allfiles-PS1\Mod09\Democode # My location

Rename-Item .\10961C_Mod09_Demo02.txt -NewName Demo02.ps1

.\Demo02.ps1

.\Demo02.ps1 LON-DC1 300

.\Demo02.ps1 -EventID 300 -ComputerName LON-DC1

PsEdit .\Demo02.ps1

#>

Param (
    [string]$ComputerName,
    [int]$EventID
)

Write-Host "The value of `$ComputerName is: $ComputerName" # =(Read-Host “Enter computer name”)
Write-Host "The value of `$EventID is: $EventID" # =300
