# Demonstration: Using background jobs

# Enable remoting if the VM has been reverted since Module 9
Enable-PSRemoting 

Start-Job -ScriptBlock { Get-ChildItem C:\ -Recurse } -Name LocalDir

Invoke-Command -ScriptBlock { Get-EventLog -LogName Security -Newest 100 } -ComputerName LON-CL1,LON-DC1 -JobName RemoteLogs

Get-Job

Get-Job -Name LocalDir | Stop-Job

Receive-Job  -Name LocalDir

Remove-Job -Name LocalDir

Wait-Job -Name RemoteLogs

Get-Job 

$id = Get-Job -Name RemoteLogs -IncludeChildJob | Where-Object location -eq 'LON-DC1' | Select-Object -ExpandProperty ID

Get-Job -ID $id | Receive-Job -Keep 

Receive-Job -Name RemoteLogs

Remove-Job -Name RemoteLogs
