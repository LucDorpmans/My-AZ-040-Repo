# Demonstration: Passing data ByPropertyName

# This wil generate an error 
Get-ADComputer -Filter * | Get-Process

Get-ADComputer -Filter * | Get-Member

Get-Help Get-Process -ShowWindow

Get-ADComputer -Filter { Name -like "LON*"}  |  
    Select-Object @{n='ComputerName';e={$PSItem.Name}} | 
    Get-Service -name * | 
    Select-Object -Property Name, MachineName, Status  

Get-ADComputer -Filter { Name -like "LON*"}  |  
    Select-Object @{n='ComputerName';e={$PSItem.Name}} | 
    Get-Process spoolsv | Select-Object -Property Name, MachineName  

Get-ADComputer -Filter { Name -like "LON*"}  |  
    ForEach-Object { WGet-Process -ComputerName $PSItem.Name }  |
    Select-Object $PSItem.Name


# Dit werkt wel:
Get-Process spoolsv -ComputerName LON-DC1,LON-SVR1,LON-CL1

# Dit werkt niet:
"LON-DC1","LON-SVR1","LON-CL1" |  Select-Object @{n='ComputerName';e={$PSItem.Name}} | Get-Process spoolsv | Select-Object -Property Name, MachineName  


#| Out-file E:\procs.txt 
#psedit E:\procs.txt 
