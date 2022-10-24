#################################################################
# AZ-040-Mod4-Lab: Using PSProviders and PSDrives with PowerShell

#############################################################
# Exercise 1: Creating files and folders on a remote computer
################################
###
# Task 1: Create a new folder on a remote computer
# On AZ-040T00A-LON-CL1, select Start, and then Enter powershell.
# From the results list, right-click Windows PowerShell or activate its context menu, and then select Run as administrator.
# To review help for the New-Item cmdlet in a separate window, in the Administrator: Windows PowerShell console:
Get-Help New-Item -ShowWindow

# In the output from Get-Help, notice the -Name and -ItemType parameters, then review the example commands, and close the New-Item Help window.
# To create a new ScriptShare folder in \\Lon-Svr1\C$\, in the console:
New-Item -Path \\Lon-Svr1\C$\ -Name ScriptShare -ItemType Directory

###
# Task 2: Create a new PSDrive mapping to the remote file folder
# To display the help for the New-PSDrive cmdlet:
Get-Help New-PSDrive -ShowWindow
# Review the following information, and then close the New-PSDrive Help window:
# Help information
# -Name, -Root, and -PSProvider parameters
# Example commands

# To create a new PSDrive mapping:
New-PSDrive -Name ScriptShare -Root \\Lon-Svr1\c$\ScriptShare -PSProvider FileSystem

###
# Task 3: Create a file on the mapped drive
# To review help for the Set-Location cmdlet:
Get-Help Set-Location -ShowWindow
# Review the help information, and then close the Set-Location Help window.

# To change to the ScriptShare: location:
Set-Location ScriptShare:

# To create a new file:
New-Item script.txt

# To review a directory listing:
Get-ChildItem
# Verify that the script.txt file is listed.

#############################################################
# Exercise 2: Creating a registry key for your future scripts
#############################################################
# Task 1: Create the registry key to store script configurations

# To review the contents of the Software registry key, in the Windows PowerShell console:
Get-ChildItem -Path HKCU:\Software
# Enter the following command:
New-Item -Path HKCU:\Software -Name Scripts

###
# Task 2: Create a new registry value to store the name of the PSDrive
# To change location to HKCU:\Software\Scripts:
Set-Location HKCU:\Software\Scripts

# To create a PSDriveName registry value:
New-ItemProperty -Path HKCU:\Software\Scripts -Name "PSDriveName" -Value "ScriptShare"

# To review the PSDriveName registry value:
Get-ItemProperty . -Name PSDriveName
###################################################
# Exercise 3: Creating a new Active Directory group
###################################################
###
# Task 1: Create a PSDrive that maps to the Users container in AD DS
# To load the ActiveDirectory module, in the Windows PowerShell console:
Import-Module ActiveDirectory

# To create a new AdatumUsers PSDrive:
New-PSDrive -Name AdatumUsers -Root "CN=Users,DC=Adatum,DC=com" -PSProvider ActiveDirectory

# To change location to the AdatumUsers drive:
Set-Location AdatumUsers:
###
# Task 2: Create the London Developers group
# To create the London Developers group:
New-Item -ItemType group -Path . -Name "CN=London Developers"

# To list items in the current drive:
Get-ChildItem
# Verify that the London Developers group is listed.

# End of Mod 4 Lab
