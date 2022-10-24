# Demonstration: Measuring objects

Get-Service | Measure-Object

Get-ADUser -Filter * | Measure-Object

Get-Process | Measure-Object -Property VM -Sum -Average

Get-Process | Measure-Object -Property VM -Sum -Average -Maximum -Minimum
