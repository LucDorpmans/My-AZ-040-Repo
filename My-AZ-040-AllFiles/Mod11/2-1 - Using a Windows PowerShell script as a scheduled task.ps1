# Demonstration: Using a Windows PowerShell script as a scheduled task

# Demonstration: Using a Windows PowerShell script as a scheduled task
<# 
1. On LON-DC1, in Server Manager, click Tools, and then select Active Directory Users and Computers.

2. In the Active Directory Users and Computers console tree, select and expand Adatum.com, and then select Managers.

3. In the details pane of Managers, select one of the user accounts. Right-click the account, and then
select Disable Account, and then click OK in the popup window. Minimize Active Directory Users
and Computers.

4. Click Start, type Task Scheduler, and then select Task Scheduler from the content menu.

5. In the Task Scheduler, in the console tree, right-click Task Scheduler (local) and select Create task.

6. In the Create Task window, in the General tab, in the Name and Description text boxes, type
Delete Disabled User from Managers Security Group. In the Security options, select the Run
whether user is logged on or not, and then select the Run with highest privileges check box.

7. On the Triggers tab, click the New button, and in the New Trigger window, under Settings, select
Daily. In the Start time text box, change the time to 5 minutes from the current time, and then click OK.

8. On the Action tab, click the New button. In the New Action window, in the Program/script text
box, type PowerShell.exe

9. In the Add arguments (optional): text box, type 
    -ExecutionPolicy Bypass E:\Labfiles\Mod11\DeleteDisabledUserManagersGroup.ps1
and then click OK. If a pop-up window appears, select Yes.

10. On the Conditions tab, review the items, but make no changes.

11. In the Settings tab, at the bottom of the window, under If the task is already running, then the
following rule applies: click the drop-down list and select Stop the existing instance. Then click
OK.

12. In the Task Scheduler credentials pop-up, in the Password text box, type Pa55w.rd, and then click
OK.

#>
