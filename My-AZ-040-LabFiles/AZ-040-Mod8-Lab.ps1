#########################################################################
# AZ-040-Mod8-Lab: Performing remote administration with PowerShell

#####################################################
# Exercise 1: Enabling remoting on the local computer
#####################################################

# Task 1: Enable remoting for incoming connections
# Ensure that you're signed in to the AZ-040T00A-LON-CL1 virtual machine as Adatum\Administrator with the password Pa55w.rd.
# To ensure you have the correct execution policy in place, # In the Windows PowerShell command window:
Set-ExecutionPolicy RemoteSigned
# Select Yes or Enter Y to confirm the change.

# On the AZ-040T00A-LON-CL1:
Enable-PSremoting -SkipNetworkProfileCheck
# If prompted, answer Yes to all prompts by selecting Y. This will enable remoting.

# To find a command that can list session configurations:
help *sessionconfiguration*
# Note: Notice the Get-PSSessionConfiguration command.

# To list session configurations:
Get-PSSessionConfiguration
# Verify that two to four session configurations were created. Leave the Windows PowerShell window open.

############################################
# Exercise 2: Performing one-to-one remoting
############################################
###
# Task 1: Connect to the remote computer and install an operating system feature on it
# Ensure that you're still signed in to the AZ-040T00A-LON-CL1 virtual machine as Adatum\Administrator with the password Pa55w.rd.

# On AZ-040T00A-LON-CL1, to establish a one-to-one connection to AZ-040T00A-LON-DC1, enter the following command in Windows PowerShell:
Enter-PSSession -ComputerName LON-DC1

# After you're connected, to install the Network Load Balancing (NLB) feature on AZ-040T00A-LON-DC1:
Install-WindowsFeature NLB
# Wait for the command to complete.

# To disconnect:
Exit-PSSession

###
# Task 2: Test multi-hop remoting

# To establish a one-to-one remoting connection to AZ-040T00A-LON-DC1:
Enter-PSSession -ComputerName LON-DC1

# To establish a connection from AZ-040T00A-LON-DC1 to AZ-040T00A-LON-CL1:
Enter-PSSession -ComputerName LON-CL1
# Note: You should receive an error that's indicative of the second hop. By default, you cannot establish a connection through an already-established connection.

# To close the connection:
Exit-PSSession

###
# Task 3: Observe remoting limitations
# Ensure that you're signed in to the AZ-040T00A-LON-CL1 virtual machine as Adatum\Administrator with the password Pa55w.rd.

# To establish a one-to-one connection to AZ-040T00A-LON-CL1:
Enter-PSSession -ComputerName localhost

# Enter the following command:
Notepad
# Note: Notice that the shell seems to stop responding while it waits for Notepad to open, 
# because Notepad is a graphical application, and the shell has no way to display the graphical user interface (GUI).
# Select Ctrl+C to cancel the process and return to a shell prompt.

# To disconnect:
Exit-PSSession

#############################################
# Exercise 3: Performing one-to-many remoting
#############################################

###
# Task 1: Retrieve a list of physical network adapters from two computers
# Ensure that you're still signed in to the AZ-040T00A-LON-CL1 virtual machine as Adatum\Administrator with the password Pa55w.rd.
# On AZ-040T00A-LON-CL1, to find a command that can list network adapters, enter the following command # In the Windows PowerShell window:
help *adapter*
# Note: Note the Get-NetAdapter command.

# To review the Help for the command:
help Get-NetAdapter 
# Note: Note the -Physical parameter.

# To run the command on AZ-040T00A-LON-DC1 and AZ-040T00A-LON-CL1 by means of remoting:
Invoke-Command -ComputerName LON-CL1,LON-DC1 -ScriptBlock { Get-NetAdapter -Physical }

###
# Task 2: Compare the output of a local command to that of a remote command
# To review the members of a Process object:
Get-Process | Get-Member

# To review the members from a remote Process object:
Invoke-Command -ComputerName LON-DC1 -ScriptBlock { Get-Process } | Get-Member
# Note: The second set of results only includes two MemberType of Methods; GetType, and ToString. This is because the remote value TypeName is deserialized in comparison to the local output.

#####################################
# Exercise 4: Using implicit remoting
#####################################
###
# Task 1: Create a persistent remoting connection to a server
# On AZ-040T00A-LON-CL1, ensure that you're signed in as Adatum\Administrator with the password Pa55w.rd.

# In the Windows PowerShell command window, create a persistent connection to AZ-040T00A-LON-DC1 and store it in a variable. 
# Enter the following command:
$dc = New-PSSession -ComputerName LON-DC1

# To review the PSSession list # In the variable:
$dc
# Note: Verify that the connection is available.

###
# Task 2: Import and use a module from a server
# To display a list of modules on AZ-040T00A-LON-DC1:
Get-Module -ListAvailable -PSSession $dc

# To find a module on AZ-040T00A-LON-DC1 that can work with Server Message Block (SMB) shares:
Get-Module -ListAvailable -PSSession $dc | Where { $_.Name -Like '*share*' }

# To import the module from AZ-040T00A-LON-DC1 to your local computer, and to add the prefix DC to the important commands' nouns:
Import-Module -PSSession $dc -Name SMBShare -Prefix DC

# To display a list of shares on AZ-040T00A-LON-DC1:
Get-DCSMBShare
# Note: Because this command implicitly runs on AZ-040T00A-LON-DC1, the command will display shares on that computer.

# To display a list of shares on the local computer:
Get-SMBShare
# Note: Because you added the DC prefix to the imported commands, the local commands are still available by their original name.

###
# Task 3: Close all open remoting connections
# In the Windows PowerShell command window:
Get-PSSession | Remove-PSSession
# Note that the command to verify that the remoting session has been closed isn't explicitly called out # In the sample answer script provided at E:\Mod08\Labfiles\ImplicitRemoting.ps1.txt. 

# To verify the remoting connection has been closed:
Get-PSSession
# Note: Verify that no sessions are returned.

#########################################
# Exercise 5: Managing multiple computers
#########################################
###
# Task 1: Create PSSessions to two computers
# Ensure that you're still signed in to AZ-040T00A-LON-CL1 as Adatum\Administrator with the password Pa55w.rd.

# To create PSSessions to AZ-040T00A-LON-CL1 and AZ-040T00A-LON-DC1, and to save those in a variable:
$computers = New-PSSession -ComputerName LON-CL1,LON-DC1

# To verify the connections:
$computers
# Note: Verify that two connections display as available.

# Task 2: Create a report that displays Windows Firewall rules from two computers
# To find a module capable of working with network security:
Get-Module *security* -ListAvailable
# Note the Net-Security module # In the list.

# To load the module into memory on AZ-040T00A-LON-CL1 and AZ-040T00A-LON-DC1:
Invoke-Command -Session $computers -ScriptBlock { Import-Module NetSecurity }

# To find a command that can display Windows Firewall rules:
Get-Command -Module NetSecurity
# Note: Observe the Get-NetFirewallRule command.

# If you want to review the Help for the command:
Help Get-NetFirewallRule -ShowWindow
# Note: If Help isn't displaying correctly, run the commands from steps 1 to 3 # In the Windows PowerShell command window as administrator rather than in Windows PowerShell ISE.
# Close the Get-NetFirewallRule Help window.

# To display a list of enabled firewall rules on AZ-040T00A-LON-DC1 and AZ-040T00A-LON-CL1:
Invoke-Command -Session $computers -ScriptBlock { Get-NetFirewallRule -Enabled True } | Select Name,PSComputerName

# To unload the module on AZ-040T00A-LON-DC1 and AZ-040T00A-LON-CL1:
Invoke-Command -Session $computers -ScriptBlock { Remove-Module NetSecurity }

###
# Task 3: Create and display an HTML report that displays local disk information from two computers
# To display a list of local hard drives filtered to include only those with a drive type of 3:
Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=3"

# To run the same command on AZ-040T00A-LON-DC1 and AZ-040T00A-LON-CL1 by means of remoting:
Invoke-Command -Session $computers -ScriptBlock { Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=3" }
# Note: Your report must include each computer's name, each drive's letter, and each drive's free space and total size in bytes.

# To produce an HTML report containing the results of the previous command:
Invoke-Command -Session $computers -ScriptBlock { Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=3" } | ConvertTo-Html -Property PSComputerName,DeviceID,FreeSpace,Size

###
# Task 4: Close all open PSSessions

# To close all open PSSessions:
Get-PSSession | Remove-PSSession

# End of Mod 8 Lab