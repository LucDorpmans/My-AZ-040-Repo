# Demonstration: Finding methods and documentation

Get-WmiObject -ClassName Win32_Service | Get-Member 

Get-WmiObject -Class Win32_Service | Get-Member | Where-Object Name -eq 'Change' | Format-List Name,Definition

Get-CimClass -Class Win32_Service | Select-Object -ExpandProperty CimClassMethods | Sort-Object -Property Name

Get-CimClass -Class Win32_Service | Get-Member
