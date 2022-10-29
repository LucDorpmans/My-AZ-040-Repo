# RSAT Win10 Selection for AZ-040
Get-WindowsCapability -Name RSAT* -Online | Select-Object -Property Name, State | Sort-Object -Property Name | Select-Object Name, State

Get-WindowsCapability -Name Rsat.ActiveDirectory.DS-LDS.Tools* -Online | Add-WindowsCapability -Online
Get-WindowsCapability -Name Rsat.DHCP.Tools~~~~0.0.1.0 -Online | Add-WindowsCapability -Online
Get-WindowsCapability -Name Rsat.Dns.Tools~~~~0.0.1.0 -Online | Add-WindowsCapability -Online
Get-WindowsCapability -Name Rsat.FileServices.Tools~~~~0.0.1.0 -Online | Add-WindowsCapability -Online
Get-WindowsCapability -Name Rsat.GroupPolicy.Management.Tools~~~~0.0.1.0  -Online | Add-WindowsCapability -Online
Get-WindowsCapability -Name Rsat.ServerManager.Tools~~~~0.0.1.0  -Online | Add-WindowsCapability -Online
Get-WindowsCapability -Name * -Online | Add-WindowsCapability -Online
# Get-WindowsCapability -Name "RSAT*" -Online | Add-WindowsCapability -Online
