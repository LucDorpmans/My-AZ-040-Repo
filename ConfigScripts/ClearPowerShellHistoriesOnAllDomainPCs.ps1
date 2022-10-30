Write-Output "Clearing PowerShell Histories on:"
Invoke-Command -ComputerName LON-CL1, LON-CL2, LON-CL3, LON-SVR1, LON-DC1 -ScriptBlock {
    Write-Output $($ENV:COMPUTERNAME)
    # Clear PowerShell ISE MRU list
    $configpath = "$ENV:UserProfile\AppData\Local\microsoft_corporation\powershell_ise.exe_StrongName_lw2v2vm3wmtzzpebq33gybmeoxukb04w\3.0.0.0\user.config"
    [xml]$config = Get-Content $configpath
    # (Select-Xml -Xml $config -XPath '//setting[@name="MRU"]').node.Value.ArrayOfString
    $MRUArr = (Select-Xml -Xml $config -XPath '//setting[@name="MRU"]').node.Value.ArrayOfString
    If (!($MRUArr -is "String" )) { $MRUArr.RemoveAll() }
    $config.save($configpath)
    
    # And clear PowerShell Console History:
    Remove-Item "$ENV:UserProfile\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt" -ErrorAction SilentlyContinue

} 
Write-Output "Done clearing PowerShell Histories"

