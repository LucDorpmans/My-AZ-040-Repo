# Sending local variables to a remote computer

$dc = New-PSSession -ComputerName LON-DC1

$all = New-PSSession -ComputerName LON-DC1,LON-CL1

Get-PSSession

$dc

Enter-PSSession -Session $dc

Get-Process

Exit-PSSession

$dc

Invoke-Command -Session $all -ScriptBlock { Get-Service | Where-Object { $_.Status -eq 'Running' }}

$dc | Remove-PSSession

# $dc still shows the removed connection:
$dc
# So better clear that variable:
Clear-Variable dc

Get-PSSession

Get-PSSession | Remove-PSSession
