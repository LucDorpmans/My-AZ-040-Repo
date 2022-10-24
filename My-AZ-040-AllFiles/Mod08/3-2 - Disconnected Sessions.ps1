# Demonstration: Disconnected sessions

$dc = New-PSSession -ComputerName LON-DC1

Disconnect-PSSession -Session $dc

Get-PSSession -ComputerName LON-DC1

Get-PSSession -ComputerName LON-DC1 | Connect-PSSession

$dc 
# confirm that the session is available

Remove-PSSession -Session $dc
Clear-Variable dc
