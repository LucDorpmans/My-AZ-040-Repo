# Demonstration: Expanding property values

Get-ADComputer -filter *

Get-Service -ComputerName (Get-ADComputer -filter *)

Get-ADComputer -Filter * | Get-Member

Help Get-Service -ShowWindow

Get-ADComputer -Filter * | Select-Object -Property Name

Get-ADComputer -Filter * | Select-Object -Property Name | Get-Member

Get-ADComputer -Filter * | Select-Object -ExpandProperty Name

Get-ADComputer -Filter * | Select-Object -ExpandProperty Name | Get-Member

(Get-ADComputer -Filter * | Select-Object -ExpandProperty Name)

Get-Service -ComputerName (Get-ADComputer -Filter * | Select-Object -ExpandProperty Name)
