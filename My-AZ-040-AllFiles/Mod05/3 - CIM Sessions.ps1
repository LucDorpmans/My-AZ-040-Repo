# Demonstration: Using CIMSession objects

$sess = New-CimSession -ComputerName LON-DC1

Get-CimInstance -CimSession $sess -ClassName Win32_OperatingSystem

$sess | Remove-CimSession
