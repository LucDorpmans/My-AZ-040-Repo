#########################################################################
# AZ-040-Mod10-Lab: Jobs management with PowerShell
#############################################################
# Labs 10-11: AZ-040T00 Automating Administration with Windows PowerShell

################################
# Exercise 1: Starting and managing jobs
################################
###
# Task 1: Start a Windows PowerShell remote job
# Ensure that you're signed into AZ-040T00A-LON-CL1 as Adatum\Administrator with the password Pa55w.rd.

# To start a Windows PowerShell remote job that retrieves a list of physical network adapters from AZ-040T00A-LON-DC1 and AZ-040T00A-LON-SVR1:
Invoke-Command -ScriptBlock { Get-NetAdapter -Physical } -ComputerName LON-DC1,LON-SVR1 -AsJob -JobName RemoteNetAdapt

# To start a Windows PowerShell remote job that retrieves a list of Server Message Block (SMB) shares from AZ-040T00A-LON-DC1 and AZ-040T00A-LON-SVR1:
Invoke-Command -ScriptBlock { Get-SMBShare } -ComputerName LON-DC1,LON-SVR1 -AsJob -JobName RemoteShares

# To start a Windows PowerShell remote job that retrieves all instances of the Win32_Volume class from every computer in Active Directory Domain Services (AD DS), enter the following commands, and then press the Enter key after each:
Enable-PSRemoting -SkipNetworkProfileCheck -Force
Invoke-Command -ScriptBlock { Get-CimInstance -ClassName Win32_Volume } -ComputerName (Get-ADComputer -Filter * | Select -Expand Name) -AsJob -JobName RemoteDisks
# Note: You need to enable PowerShell Remoting on LON-CL1 in order to connect to it by using PowerShell Remoting, which is, by default, disabled on Windows 10. The RemoteDisk targets all domain computers, including LON-CL1.
# Note: Because some of the computers in the domain might not be online, this job might not complete successfully. This is expected behavior.

###
# Task 2: Start a local job
# To start a local job that retrieves all entries from the Security event log:
Start-Job -ScriptBlock { Get-EventLog -LogName Security } -Name LocalSecurity

# To start a local job that produces 100 directory listings:
Start-Job -ScriptBlock { 1..100 | ForEach-Object { Dir C:\ -Recurse } } -Name LocalDir
# Note: This job will take a long time to complete. Don't wait for it to complete. Proceed to the next task.

###
# Task 3: Review and manage job status
# Ensure that you're signed in to AZ-040T00A-LON-CL1 as Adatum\Administrator with the password Pa55w.rd.

# To display a list of running jobs:
Get-Job

# To display a list of running jobs whose names start with remote:
Get-Job -Name Remote*

# To stop the LocalDir job:
Stop-Job -Name LocalDir
# Run 
Get-Job 
#until there are no jobs with the status of Running.

# To receive the results of the RemoteNetAdapt job:
Receive-Job -Name RemoteNetAdapt

# To receive the results of the RemoteDisks job:
Get-Job -Name RemoteDisks -IncludeChildJob | Receive-Job


####################################
Exercise 2: Creating a scheduled job
####################################
###
# Task 1: Create job options and a job trigger
# Ensure that you're signed in to AZ-040T00A-LON-CL1 as Adatum\Administrator with the password Pa55w.rd.

# To create a new job option:
$option = New-ScheduledJobOption -WakeToRun -RunElevated

# To create a new job trigger:
$trigger1 = New-JobTrigger -Once -At (Get-Date).AddMinutes(5)

###
# Task 2: Create a scheduled job and retrieve results

# To register the job:
Register-ScheduledJob -ScheduledJobOption $option `
	-Trigger $trigger1 `
	-ScriptBlock { Get-EventLog -LogName Security } `
	-Name LocalSecurityLog

# To display a list of job triggers:
Get-ScheduledJob -Name LocalSecurityLog | Select -Expand JobTriggers 
# Note the time that displays, and then wait until the time returned in the output of step 2 has passed.

# To display a list of jobs:
Get-Job

# To receive the job results, wait until 5 minutes passed from the time you registered the LocalSecurityLog job, then enter the following command, and press the Enter key:
Receive-Job -Name LocalSecurityLog
# Note: Verify that the output consists of a list of log entries.

###
# Task 3: Use a Windows PowerShell script as a scheduled task
# Switch to the console session to AZ-040T00A-LON-DC1 and, if needed, sign into AZ-040T00A-LON-DC1 as Adatum\Administrator with the password Pa55w.rd.
# On AZ-040T00A-LON-DC1, in Server Manager, select Tools, and then select Active Directory Users and Computers.
# In the Active Directory Users and Computers console tree, select and expand Adatum.com, and then select Managers.
# In the details pane of Managers, select one of the user accounts, such as Adam Hobbs. Right-click the account or activate its context menu, and then select Disable Account.
# Double-click the user you disabled, or select it and then press the Enter key.
# Select the Member of tab and verify that the user is a member of the Managers security group.
# Select OK and then minimize Active Directory Users and Computers.
# Select Start, Enter Task Scheduler, and then select Task Scheduler.
# In Task Scheduler, in the console tree, right-click Task Scheduler (local) or activate its context menu, and then select Create Task.
# In the Create Task window, in the General tab, in the Name and Description boxes, Enter Remove Disabled User from Managers Security Group.
# In the Security options section, select Run whether user is logged on or not, and then select the Run with highest privileges checkbox.
# In the Triggers tab, select New.
# In the New Trigger window, in Settings, select Daily, in the Start time box, change the time to 5 minutes from the current time, and then select OK.

# Note: If you get a Task Scheduler pop-up window, select OK.
# In the Actions tab, select New.
# In the New Action window, in the Program/script box, Enter PowerShell.exe.
# In the Add arguments (optional) box, Enter -ExecutionPolicy Bypass E:\Labfiles\\Mod11\DeleteDisabledUserManagersGroup.ps1, select OK and then, in a pop-up window, select Yes.
# In the Conditions tab, review the items, but make no changes.
# In the Settings tab, in the If the task is already running, then the following rule applies: drop-down list, select Stop the existing instance, and then select OK.
# In the Task Scheduler credentials pop-up window, in the Password box, Enter Pa55w.rd, and then select OK.
# In Task Scheduler, select Task Schedule Library and then in the details pane, select Remove Disabled User from Managers Security Group.
# In the details pane, select the History tab. After the five minutes pass, select Refresh in the Actions pane. You should notice an item with the Task Category of Task completed.
# Maximize Active Directory Users and Computers.
# Double-click the user you disabled, or select it and then press the Enter key.
# Select the Member of tab. The user should no longer be a member of the Managers security group.
# 
# End of Mod 11 Lab