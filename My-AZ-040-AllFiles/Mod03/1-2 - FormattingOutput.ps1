# Demonstration: Formatting pipeline output

Get-Service

Get-Service | Format-Table -Property Name, Status

Get-Service | Format-List -Property *

Get-Service | Format-Table -Property * -wrap


Get-ADComputer -Filter * 

# This does not produce output for the property OperatingSystem because is not included in the default property list
Get-ADComputer -Filter * | Format-Table -Property Name, OperatingSystem

Get-ADComputer -Filter * -Properties OperatingSystem 

Get-ADComputer -Filter * -Properties OperatingSystem | Format-Table -Property Name, OperatingSystem

Get-ADUser -Filter *

Get-ADUser -Filter * | Format-Wide -AutoSize
