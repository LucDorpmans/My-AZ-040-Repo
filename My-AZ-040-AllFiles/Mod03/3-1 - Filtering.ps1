# Demonstration: Filtering 

Get-SMBShare | Where-Object Name -like '*$*'

Get-PhysicalDisk | 
    Where-Object -FilterScript { $PSItem.HealthStatus -eq 'Healthy' } | 
    Select-Object -Property FriendlyName,OperationalStatus

Get-PhysicalDisk | 
    Where-Object -FilterScript { $PSItem.HealthStatus -eq 'Healthy' } | 
    Select-Object -Property FriendlyName,OperationalStatus,DriveLetter,FileSystemLabel,DriveType,FileSystem | 
    Format-List

Get-Verb | Where-Object { $_.Verb -like 'c*' } | Format-Wide
