# Demonstration: Configuring network settings

Test-Connection LON-DC1.adatum.com

Get-NetIPConfiguration

Set-NetIPAddress -InterfaceAlias Ethernet -IPAddress 172.16.0.40 -PrefixLength 24 -AddressFamily IPv4

Get-DnsClientCache
Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses 172.16.0.11

Remove-NetRoute -InterfaceAlias Ethernet -DestinationPrefix 0.0.0.0/0 

New-NetRoute -InterfaceAlias Ethernet -DestinationPrefix 0.0.0.0/0 -NextHop 172.16.0.2

Get-NetIPConfiguration

Test-Connection LON-DC1.adatum.com
Get-DnsClientCache

# Repair IP settings so  revert is not required
Set-NetIPAddress -InterfaceAlias Ethernet -IPAddress 172.16.0.40 -PrefixLength 16
Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses 172.16.0.10
Remove-NetRoute -InterfaceAlias Ethernet -DestinationPrefix 0.0.0.0/0 -Confirm:$false
New-NetRoute -InterfaceAlias Ethernet -DestinationPrefix 0.0.0.0/0 -NextHop 172.16.0.1

