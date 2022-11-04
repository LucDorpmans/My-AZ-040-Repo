# Demonstration: Using scheduled jobs

Import-Module PSScheduledJob
Get-Job | Remove-Job

$trigger = New-JobTrigger -Once -At (Get-Date).AddMinutes(2)

$SchedJobName = "DemoJob"
Register-ScheduledJob -Trigger $trigger -Name $SchedJobName -ScriptBlock { Get-EventLog -LogName Application -Newest 10 }

Get-ScheduledJob | Select-Object -Expand JobTriggers 
# Notice the time

Get-ScheduledJob 
# wait until after the time that was displayed in the previous step.

Get-Job

Receive-Job -Name $SchedJobName

Get-Job -Name $SchedJobName | Remove-Job

Get-ChildItem "$env:HOMEPATH\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs" -Recurse
# Get-ChildItem C:\Users\Administrator.ADATUM\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs -Recurse
PSEdit "C:\Users\Administrator.ADATUM\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs\DemoJob\ScheduledJobDefinition.xml"

#Cleanup (for next time)
Get-ScheduledJob -Name $SchedJobName | Unregister-ScheduledJob  

