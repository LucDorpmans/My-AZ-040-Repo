
# Demonstration: Using scheduled jobs

Import-Module PSScheduledJob
Get-Job | Remove-Job

$trigger = New-JobTrigger -Once -At (Get-Date).AddMinutes(2)

Register-ScheduledJob -Trigger $trigger -Name DemoJob -ScriptBlock { Get-EventLog -LogName Application }

Get-ScheduledJob | Select-Object -Expand JobTriggers 
# notice the Time

Get-ScheduledJob 
# wait until after the time that was displayed in the previous step.

Get-Job

Receive-Job -Name DemoJob

Get-Job -Name DemoJob | Remove-Job







