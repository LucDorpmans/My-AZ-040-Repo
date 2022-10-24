﻿Get-WindowsCapability -Name RSAT* -Online | Select-Object -Property Name, State | Sort-Object -Property Name | Select Name | Out-File C:\Temp\RSAT-List.txt
PSEdit C:\Temp\RSAT-List.txt

Get-WindowsCapability -Name Rsat.ActiveDirectory.DS-LDS.Tools* -Online | Add-WindowsCapability -Online
Get-WindowsCapability -Name Rsat.DHCP.Tools~~~~0.0.1.0 -Online | Add-WindowsCapability -Online
Get-WindowsCapability -Name Rsat.Dns.Tools~~~~0.0.1.0 -Online | Add-WindowsCapability -Online
Get-WindowsCapability -Name Rsat.FileServices.Tools~~~~0.0.1.0 -Online | Add-WindowsCapability -Online
Get-WindowsCapability -Name Rsat.GroupPolicy.Management.Tools~~~~0.0.1.0  -Online | Add-WindowsCapability -Online
Get-WindowsCapability -Name Rsat.ServerManager.Tools~~~~0.0.1.0  -Online | Add-WindowsCapability -Online
Get-WindowsCapability -Name * -Online | Add-WindowsCapability -Online
# Get-WindowsCapability -Name "RSAT*" -Online | Add-WindowsCapability –Online

<# 
Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0 
Rsat.BitLocker.Recovery.Tools~~~~0.0.1.0 
Rsat.CertificateServices.Tools~~~~0.0.1.0 
Rsat.DHCP.Tools~~~~0.0.1.0 
Rsat.Dns.Tools~~~~0.0.1.0 
Rsat.FailoverCluster.Management.Tools~~~~0.0.1.0 
Rsat.FileServices.Tools~~~~0.0.1.0 
Rsat.GroupPolicy.Management.Tools~~~~0.0.1.0 
Rsat.IPAM.Client.Tools~~~~0.0.1.0 
Rsat.LLDP.Tools~~~~0.0.1.0 
Rsat.NetworkController.Tools~~~~0.0.1.0 
Rsat.NetworkLoadBalancing.Tools~~~~0.0.1.0 
Rsat.RemoteAccess.Management.Tools~~~~0.0.1.0 
Rsat.RemoteDesktop.Services.Tools~~~~0.0.1.0 
Rsat.ServerManager.Tools~~~~0.0.1.0 
Rsat.Shielded.VM.Tools~~~~0.0.1.0 
Rsat.StorageMigrationService.Management.Tools~~~~0.0.1.0
Rsat.StorageReplica.Tools~~~~0.0.1.0 
Rsat.SystemInsights.Management.Tools~~~~0.0.1.0 
Rsat.VolumeActivation.Tools~~~~0.0.1.0 
Rsat.WSUS.Tools~~~~0.0.1.0 
#> 
