##############################################
# AZ-040-Mod3A-Lab:  Using PowerShell pipeline

#####################################################
# Exercise 1: Selecting, sorting, and displaying data
################################
# Task 1: Display the current day of the year
# On AZ-040T00A-LON-CL1, select Start, and then Enter powershell.

# In the  search results, right-click Windows PowerShell or activate its context menu, and then select Run as administrator.

# In the  Administrator: Windows PowerShell window:
help *date* 
# Note: Notice the Get-Date command.

# In the  console:
Get-Date | Get-Member
# Note: Notice the DayOfYear property.

# In the  console:
Get-Date | Select-Object -Property DayOfYear

# In the  console:
Get-Date | Select-Object -Property DayOfYear | Format-List

###
# Task 2: Display information about installed hotfixes
# In the  console:
Get-Command *hotfix* 
# Note: Notice the Get-Hotfix command.

# In the  console:
Get-Hotfix | Get-Member 
# Note: The properties of the Hotfix object display. If needed, run Get-Hotfix to review some of the values that typically display in those properties.

# In the  console:
Get-Hotfix | Select-Object -Property HotFixID,InstalledOn,InstalledBy

# In the  console:
Get-Hotfix | Select-Object -Property HotFixID,@{n='HotFixAge';e={(New-TimeSpan -Start $PSItem.InstalledOn).Days}},InstalledBy

###
# Task 3: Display a list of available scopes from the DHCP server
# In the  console:
help *scope* 
# Note: Notice the Get-DHCPServerv4Scope command.

# In the  console:
Help Get-DHCPServerv4Scope -ShowWindow 
# Note: Notice the available parameters.
# Close the Get-DHCPServerv4Scope window.

# In the  console:
Get-DHCPServerv4Scope -ComputerName LON-DC1
# In the  console:
Get-DHCPServerv4Scope -ComputerName LON-DC1 | Select-Object -Property ScopeId,SubnetMask,Name | Format-List

###
# Task 4: Display a sorted list of enabled Windows Firewall rules
# In the  console:
help *rule* 
# Note: Notice the Get-NetFirewallRule command.

# In the  console:
Get-NetFirewallRule 
# In the  console:
Help Get-NetFirewallRule -ShowWindow
# Close the Get-NetFirewallRule Help window.

# In the  console:
Get-NetFirewallRule -Enabled True

# In the  console:
Get-NetFirewallRule -Enabled True | Format-Table -wrap

# In the  console:
Get-NetFirewallRule -Enabled True | Select-Object -Property DisplayName,Profile,Direction,Action | Sort-Object -Property Profile, DisplayName | ft -GroupBy Profile

###
# Task 5: Display a sorted list of network neighbors
# In the  console:
help *neighbor*  
# Note: Notice the Get-NetNeighbor command.

# In the  console:
help Get-NetNeighbor -ShowWindow
# Close the Get-NetNeighbor Help window.

# In the  console:
Get-NetNeighbor

# In the  console:
Get-NetNeighbor | Sort-Object -Property State

# In the  console:
Get-NetNeighbor | Sort-Object -Property State | Select-Object -Property IPAddress,State | Format-Wide -GroupBy State -AutoSize

###
# Task 6: Display information from the DNS name resolution cache
# In the  console:
Test-NetConnection LON-DC1

# In the  console:
help *cache* 
# Note: Notice the Get-DnsClientCache command.

# In the  console:
Get-DnsClientCache

# In the  console:
Get-DnsClientCache | Select-Object Name,Type,TimeToLive | Sort-Object Name | Format-List
# Note: Notice that the Type data doesn't return what you might expect; for example, A and CNAME. Instead, it returns raw numerical data. Each number maps directly to a record type, and you can filter for those types when you know the map: 1= A, 5 = CNAME, and so on. Later in this module, you'll learn how to add more filters to determine the numbers and their corresponding record types. You'll notice a similar situation for other returned data, such as Status data.
# Close all open windows.

# Exercise 1 complete

###############################
# Exercise 2: Filtering objects
###############################
# Task 1: Display a list of all the users in the Users container of Active Directory
# On AZ-040T00A-LON-CL1, select Start, and then Enter PowerShell.

# In the  search results, right-click Windows PowerShell or activate its context menu, and then select Run as administrator.

# In the  Administrator: Windows PowerShell window:


help *user*
# Note: Notice the Get-ADUser command.

# In the  console:


Get-Help Get-ADUser -ShowWindow
# Note: Notice that the -Filter parameter is mandatory. Review the examples for the command.

Close the Get-ADUser Help window.

# In the  console:


Get-ADUser -Filter * | ft
# In the  console:


Get-ADUser -Filter * -SearchBase "cn=Users,dc=Adatum,dc=com" | ft
# Task 2: Create a report displaying the Security event log entries that have the event ID 4624
# In the  Administrator: Windows PowerShell window:


Get-EventLog -LogName Security | 
Where-Object EventID -eq 4624 | Measure-Object | fw
# In the  console, enter the following command and then press the Enter key:


Get-EventLog -LogName Security | 
Where-Object EventID -eq 4624 | 
Select-Object TimeWritten,EventID,Message
# In the  console:


Get-EventLog -LogName Security | 
Where-Object EventID -eq 4624 | 
Select TimeWritten,EventID,Message -Last 10 | fl
# Task 3: Display a list of the encryption certificates installed on the computer
# In the  Administrator: Windows PowerShell window:


Get-ChildItem -Path CERT: -Recurse
# In the  console:


Get-ChildItem -Path CERT: -Recurse | 
Get-Member
# In the  console window, enter the following command, and then press the Enter key.


Get-ChildItem -Path CERT: -Recurse | 
Where HasPrivateKey -eq $False | Select-Object -Property FriendlyName,Issuer | fl
# or:


Get-ChildItem -Path CERT: -Recurse | 
Where { $PSItem.HasPrivateKey -eq $False } | Select-Object -Property FriendlyName,Issuer | fl
# In the  console window, enter the following command, and then press the Enter key.


Get-ChildItem -Path CERT: -Recurse | 
Where { $PSItem.HasPrivateKey -eq $False -and $PSItem.NotAfter -gt (Get-Date) -and $PSItem.NotBefore -lt (Get-Date) } | Select-Object -Property NotBefore,NotAfter, FriendlyName,Issuer | ft -wrap
# Task 4: Create a report of the disk volumes that are running low on space
# In the  Administrator: Windows PowerShell window:


Get-Volume
# Note: If you didn't know the command name, you could have run Help *volume* to discover it.

# In the  console:


Get-Volume | Get-Member
# Note: Notice the SizeRemaining property.

# In the  console:


Get-Volume | Where-Object { $PSItem.SizeRemaining -gt 0 } | fl
# In the  console:


Get-Volume | Where-Object { $PSItem.SizeRemaining -gt 0 -and $PSItem.SizeRemaining / $PSItem.Size -lt .99 }| Select-Object DriveLetter, @{n='Size';e={'{0:N2}' -f ($PSItem.Size/1MB)}}
# In the  console:


Get-Volume | Where-Object { $PSItem.SizeRemaining -gt 0 -and $PSItem.SizeRemaining / $PSItem.Size -lt .1 }
# Note: This command might not produce any output on your lab computer if the computer has more than 10 percent free space on each of its volumes.

# Task 5: Create a report that displays specified Control Panel items
# In the  Administrator: Windows PowerShell window:


help *control* 
# Note: Notice the Get-ControlPanelItem command.

# In the  console:


Get-ControlPanelItem 
# In the  console:
Get-ControlPanelItem -Category 'System and Security' | Sort Name
# Note: Notice that you don't have to use Where-Object.

# In the  console:
Get-ControlPanelItem -Category 'System and Security' | Where-Object -FilterScript {-not ($PSItem.Category -notlike '*System and Security*')} | Sort-Object Name

# End of Mod 3A Lab
