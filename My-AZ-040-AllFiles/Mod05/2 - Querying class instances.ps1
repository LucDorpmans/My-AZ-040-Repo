# Demonstration: Querying class instances

Get-WmiObject -Class Win32_Service

Get-CimInstance -ClassName Win32_Process

Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3"

Get-CimInstance -Query "SELECT * FROM Win32_NetworkAdapter"
