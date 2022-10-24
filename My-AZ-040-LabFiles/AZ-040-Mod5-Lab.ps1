#################################################################
# AZ-040-Mod5-Lab: Querying information by using WMI and CIM

###############################################
# Exercise 1: Querying information by using WMI
###############################################
###
# Task 1: Query IP addresses
# On AZ-040T00A-LON-CL1, select Start, and then Enter powershell.
# In the  results list, right-click Windows PowerShell or activate its context menu, and then select Run as administrator.
# To find a repository class that lists the IP addresses being used by a computer, enter the following command in the Windows PowerShell console:
Get-WmiObject -Namespace root\cimv2 -List | Where Name -like '*configuration*' | Sort Name
# Notice the Win32_NetworkAdapterConfiguration class.

# To retrieve all instances of the class depicting static IP addresses, enter the following command in the Windows PowerShell console:
Get-WmiObject -Class Win32_NetworkAdapterConfiguration | Where DHCPEnabled -eq $False | Select IPAddress
# Remember that you can run the first command and pipe its output to Get-Member to review the properties that are available.

# Task 2: Query operating system version information
# To find a repository class that lists operating system information, enter the following command in the Windows PowerShell console:
Get-WmiObject -Namespace root\cimv2 -List | Where Name -like '*operating*' | Sort Name
# Notice the Win32_OperatingSystem class.

# To display a list of properties for the class, enter the following command in the Windows PowerShell console:
Get-WmiObject -Class Win32_OperatingSystem | Get-Member
# Notice the Version, ServicePackMajorVersion, and BuildNumber properties.

# To display the specified information, enter the following command in the Windows PowerShell console:
Get-WmiObject -Class Win32_OperatingSystem | Select Version,ServicePackMajorVersion,BuildNumber
###
# Task 3: Query computer system hardware information
# To find a repository class that displays computer system information, enter the following command in the Windows PowerShell console:
Get-WmiObject -Namespace root\cimv2 -List | Where Name -like '*system*' | Sort Name 
# Notice the Win32_ComputerSystem class.

# To display a list of instance properties and values, enter the following command in the Windows PowerShell console:
Get-WmiObject -Class Win32_ComputerSystem | Format-List -Property *
# Remember that Get-Member doesn't display property values, but Format-List can.

# To display the specified information, enter the following command in the Windows PowerShell console:
Get-WmiObject -Class Win32_ComputerSystem | Select Manufacturer,Model,@{n='RAM';e={$PSItem.TotalPhysicalMemory}}

###
# Task 4: Query service information
# To find a repository class that contains information about services, enter the following command in the Windows PowerShell console:
Get-WmiObject -Namespace root\cimv2 -List | Where Name -like '*service*' | Sort Name
# Notice the Win32_Service class.

# To display a list of instance properties and values, enter the following command in the Windows PowerShell console:
Get-WmiObject -Class Win32_Service | FL *

# To display the specified information, enter the following command in the Windows PowerShell console, and press the Enter key:
Get-WmiObject -Class Win32_Service -Filter "Name LIKE 'S%'" | Select Name,State,StartName
# Leave the Windows PowerShell console open for the next exercise.

###############################################
# Exercise 2: Querying information by using CIM
###############################################
###
# Task 1: Query user accounts
# To find a repository class that lists user accounts, enter the following command in the Windows PowerShell console:
Get-CimClass -ClassName *user*
# Notice the Win32_UserAccount class.

# To display a list of class properties, enter the following command in the Windows PowerShell console:
Get-CimInstance -Class Win32_UserAccount | Get-Member

# To display the specified information, enter the following command in the Windows PowerShell console:
Get-CimInstance -Class Win32_UserAccount | Format-Table -Property Caption,Domain,SID,FullName,Name
# Notice the returned list of all domain and local accounts.

# Task 2: Query BIOS information
# To find a repository class that contains BIOS information, enter the following command in the Windows PowerShell console:
Get-CimClass -ClassName *bios*
# Notice the Win32_BIOS class.

# To display the specified information, enter the following command in the Windows PowerShell console:
Get-CimInstance -Class Win32_BIOS

# Task 3: Query network adapter configuration information
# To display a list of all the local Win32_NetworkAdapterConfiguration instances, enter the following command in the Windows PowerShell console:
Get-CimInstance -Classname Win32_NetworkAdapterConfiguration

# To display a list of all the Win32_NetworkAdapterConfiguration instances that exist on AZ-040T00A-LON-DC1, enter the following command in the Windows PowerShell console:
Get-CimInstance -Classname Win32_NetworkAdapterConfiguration -ComputerName LON-DC1

###
# Task 4: Query user group information
# To find a repository class that lists user groups, enter the following command in the Windows PowerShell console:
Get-CimClass -ClassName *group*
# Notice the Win32_Group class.

# To display the specified information, enter the following command in the Windows PowerShell console:
Get-CimInstance -ClassName Win32_Group -ComputerName LON-DC1
# Leave the Windows PowerShell console open for the next exercise.

##############################
# Exercise 3: Invoking methods
##############################
# Task 1: Invoke a CIM method
# To restart AZ-040T00A-LON-DC1, enter the following command in the Windows PowerShell console:
Invoke-CimMethod -ClassName Win32_OperatingSystem -ComputerName LON-DC1 -MethodName Reboot

# Notice the response that includes ReturnValue=0 and PSComputerName=LON-DC1.
# Switch to the AZ-040T00A-LON-DC1 virtual machine and observe it restarting.
# When the restart is complete, switch back to the AZ-040T00A-LON-CL1 virtual machine.

# Task 2: Invoke a WMI method
# To review properties of the WinRM service, enter the following command in the Windows PowerShell console:
Get-Service WinRM | FL *
# Note that the StartType is Manual.

# To change the start mode of the specified service, enter the following command in the Windows PowerShell console:
Get-WmiObject -Class Win32_Service -Filter "Name='WinRM'" | Invoke-WmiMethod -Name ChangeStartMode -Argument 'Automatic'

# To verify that the StartType of the WinRM service has changed, enter the following command in the Windows PowerShell console:
Get-Service WinRM | FL *
# Note that the StartType is Automatic.

# End of Mod 5 Lab
