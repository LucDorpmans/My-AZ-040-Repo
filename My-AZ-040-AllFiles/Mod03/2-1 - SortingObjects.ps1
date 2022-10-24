# Demonstration: Sorting objects 

Get-Process

Get-Process | Sort-Object -Property ID

Get-Service | Sort-Object -Property Status 
# Notice that 'Stopped' appears before 'Running'. This is because the property is 
# stored as a number internally, with zero (stopped) coming before 1 (running).

Get-Service | Sort-Object -Property Status -Descending

Get-Service | Sort-Object -Property Status -Descending | Format-Table Name, DisplayName -GroupBy Status
Get-Service | Sort-Object -Property Status -Descending | Group-Object Status

Get-EventLog -LogName Security -Newest 10

Get-EventLog -LogName Security -Newest 10 | Sort-Object -Property TimeWritten

Get-ADUser -Filter * | Sort-Object -Property SurName | Format-Wide -AutoSize
