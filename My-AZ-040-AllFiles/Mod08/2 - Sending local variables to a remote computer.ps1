# Demonstration: Sending local variables to a remote computer

# Ask for number of entries
$quantity = Read-Host "Query how many log entries?"

# The hard way, using Parameters
Invoke-Command -ArgumentList $quantity -ComputerName LON-DC1 -ScriptBlock { Param($x) Get-EventLog -LogName Security -newest $x }

# The easy way using the Scope Modifier $Using
Invoke-Command -ComputerName lon-dc1 -ScriptBlock {Get-EventLog -LogName Security -Newest $Using:quantity}
