# Demonstration: Selecting objects

Get-Process | Sort-Object -Property VM -Descending | Select-Object -First 10

Get-Date | Select-Object -Property DayOfWeek

Get-EventLog -Newest 15 -LogName Security | Select-Object -Property EventID,TimeWritten,Message

Get-ADComputer -Filter * -Properties OperatingSystem | 
    Sort-Object -Property OperatingSystem | 
    Select-Object -Property OperatingSystem,Name | 
    Format-List -GroupBy OperatingSystem -Property Name
