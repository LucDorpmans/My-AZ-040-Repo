#########################################################################
# AZ-040-Mod6-Lab: Using variables, arrays, and hash tables in PowerShell

#############################################################
# Exercise 1: Working with variable types
################################

# Task 1: Use string variables
# On AZ-040T00A-LON-CL1, select Start, and then Enter powershell.

# In the  results list, right-click Windows PowerShell or activate its context menu, and then select Run as administrator.

# To set the $logPath variable, at the Windows PowerShell prompt:
$logPath = "C:\Logs\"

# To display the variable type for $logPath:
$logPath.GetType()

# To review the properties and methods for the $logPath variable:
$logPath | Get-Member

# To set the $logFile variable:
$logFile = "log.txt"

# To add the $logFile variable to the $logPath variable:
$logPath += $logFile

# To review the contents of the $logPath variable:
$logPath

# To replace C: with D: in the $logPath value:
$logPath.Replace("C:","D:")

# To replace C: with D: in $logPath:
$logPath = $logPath.Replace("C:","D:")

# To review the contents of the $logPath variable:
$logPath

###
# Task 2: Use DateTime variables
# To set the $today variable equal to today's date, at the Windows PowerShell prompt:
$today = Get-Date

# To review the variable type of the $today variable:
$today.GetType()

# To review the properties and methods for the $today variable:
$today | Get-Member

# To set a log file name based on the date:
$logFile = [string]$today.Year + "-" + $today.Month + "-" + $today.Day + "-" + $today.Hour + "-" + $today.Minute + ".txt"

# To calculate a date 30 days before today:
$cutOffDate = $today.AddDays(-30)

# To review users that haven't signed in for the last 30 days:
Get-ADUser -Properties LastLogonDate -Filter {LastLogonDate -gt $cutOffDate}

##########################
# Exercise 2: Using arrays
##########################
###
# Task 1: Use an array to update the department for users

# To query all users in the Marketing department:
$mktgUsers = Get-ADUser -Filter {Department -eq "Marketing"} -Properties Department

# To identify how many users are in the $mktgUsers variable:
$mktgUsers.count

# To review the first user in $mktgUsers:
$mktgUsers[0]

# To modify the department to Business Development:
$mktgUsers | Set-ADUser -Department "Business Development"

# To review the Name and Department of users in the $mktgUsers variable:
$mktgUsers | Format-Table Name,Department
# Review the output and verify that the Department values in the $mktgUsers variable haven't changed.

# To query all users in the Marketing department, at the Windows PowerShell prompt:
Get-ADUser -Filter {Department -eq "Marketing"}

# To query all users in the Business Development department:
Get-ADUser -Filter {Department -eq "Business Development"}

###
# Task 2: Use an array list

# To create an array list of computer names, at the Windows PowerShell prompt:
[System.Collections.ArrayList]$computers="LON-SRV1","LON-SRV2","LON-DC1"

# To verify that the $computers array list is not fixed-size:
$computers.IsFixedSize

# To add a computer name to the $computers array list:
$computers.Add("LON-DC2")

# To remove a computer name from the $computers array list:
$computers.Remove("LON-SRV2")

# To review the items in the $computers array list:
$computers

###############################
# Exercise 3: Using hash tables
###############################
###
# Task 1: Use a hash table

# To create a hash table containing names and email addresses, at the Windows PowerShell prompt:
$mailList=@{"Frank"="Frank@fabriakm.com";"Libby"="LHayward@contso.com";"Matej"="MSTaojanov@tailspintoys.com"}

# To review the contents of the $mailList hash table:
$mailList

# To review the email address for Libby:
$mailList.Libby

# To update the email address for Libby:
$mailList.Libby="Libby.Hayward@contoso.com"

# To add a new name and email address to the hash table:
$mailList.Add("Stela","Stela.Sahiti")

# To remove Frank from the hash table:
$mailList.Remove("Frank")

# To review the contents of the $mailList hash table:
$mailList

# End of Mod 10 Lab