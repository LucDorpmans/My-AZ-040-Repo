#############################################
# AZ-040-Mod3B-Lab:  Using PowerShell pipeline

#################################
# Exercise 1: Enumerating objects
################################

# Task 1: Display a list of files on drive E of your computer
# On AZ-040T00A-LON-CL1:
Get-ChildItem -Path E: -Recurse
Get-ChildItem -Path E: -Recurse | Get-Member 
# Note: Notice the GetFiles method in the list under TypeName: System.IO.DirectoryInfo.

Get-ChildItem -Path E: -Recurse | ForEach GetFiles
# Task 2: Use enumeration to produce 100 random numbers

help *random* 
# Note: Notice the Get-Random command.

help Get-Random -ShowWindow 
# Note: Notice the -SetSeed parameter.

1..100 
1..100 | ForEach { Get-Random -SetSeed $PSItem }

# Task 3: Run a method of a Windows Management Instrumentation (WMI) object
Get-WmiObject -Class Win32_OperatingSystem -EnableAllPrivileges
Get-WmiObject -Class Win32_OperatingSystem -EnableAllPrivileges | Get-Member
# Note: Notice the Reboot method.
# Note: The following command will reboot the machine you run it on.
Get-WmiObject -Class Win32_OperatingSystem -EnableAllPrivileges | ForEach Reboot


# Exercise 2: Converting objects
# Task 1: Update Active Directory user information
# **# Note:** In this lab, long commands typically display on several lines. 
# This helps to prevent unintended line breaks in the middle of commands. 
# However, when you enter these commands, you should enter them as a single line. 
# That line might wrap on your screen into multiple lines, but the command will still work. 
# press the Enter key only after entering the entire command.

# On AZ-040T00A-LON-CL1:
Get-ADUser -Filter * -Properties Department,City | Where {$PSItem.Department -eq 'IT' -and $PSItem.City -eq 'London'} | Select-Object -Property Name,Department,City| Sort Name
Get-ADUser -Filter * -Properties Department,City | Where {$PSItem.Department -eq 'IT' -and $PSItem.City -eq 'London'} | Set-ADUser -Office 'LON-A/1000'
Get-ADUser -Filter * -Properties Department,City,Office | Where {$PSItem.Department -eq 'IT' -and $PSItem.City -eq 'London'} | Select-Object -Property Name,Department,City,Office | Sort Name

# Task 2: Generate files listing the Active Directory users in the IT department
help ConvertTo-Html -ShowWindow

Get-ADUser -Filter * -Properties Department,City,Office | 
Where {$PSItem.Department -eq 'IT' -and $PSItem.City -eq 'London'} | 
Sort Name | 
Select-Object -Property Name,Department,City,Office |
ConvertTo-Html -Property Name,Department,City -PreContent Users | 
Out-File E:\UserReport.html

#To review the HTML file:
Invoke-Expression E:\UserReport.html

Get-ADUser -Filter * -Properties Department,City,Office | 
Where {$PSItem.Department -eq 'IT' -and $PSItem.City -eq 'London'} | 
Sort Name | 
Select-Object -Property Name,Department,City,Office |
Export-Clixml E:\UserReport.xml
# Review the report displayed on the web browser page and then close the web browser window.


Get-ADUser -Filter * -Properties Department,City,Office | 
Where {$PSItem.Department -eq 'IT' -and $PSItem.City -eq 'London'} | 
Sort Name | 
Select-Object -Property Name,Department,City,Office |
Export-Csv E:\UserReport.csv
PSEdit E:\UserReport.csv
# Open File Explorer, in the File Explorer window, navigate to E:\, right-click UserReport.csv or activate its context menu, select Open with, and then select Notepad.

# End of Mod 3B Lab
