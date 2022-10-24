# Demonstration: Listing local repository namespaces by using WMI:
Get-WmiObject -Namespace root -List -Recurse | Select-Object -Unique __NAMESPACE


# Demonstration: Listing and sorting the classes from a namespace
Get-CimClass -Namespace root/SecurityCenter2

Get-CimClass -Namespace root\CIMv2

Get-CimClass -Namespace root\CIMv2 | Sort-Object CimClassName

Get-CimClass *network* | Sort-Object CimClassName
# This finds all the classes in the root\CIMv2 namespace that have 'network' in the class name
