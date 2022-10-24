# Demonstration: Managing the file system

Set-Location C:\

Set-Location C:\Windows

New-PSDrive -Name WINDIR -Root C:\Windows -PSProvider FileSystem

Get-ChildItem WINDIR:

Get-ChildItem WINDIR:

New-Item E:\Temp -ItemType Directory
