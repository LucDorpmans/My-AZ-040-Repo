# Demonstration: Basic enumeration

Get-Service | ForEach-Object Name

Get-EventLog -List

Get-EventLog -List | Where-Object Log -eq 'System' | ForEach-Object Clear
