# Demonstration: Using parenthetical commands

New-ADGroup "London Users" -GroupScope Global -GroupCategory Security

# This won't work, PowerShell will ask for a value:
Get-ADGroup "London Users" | Add-ADGroupMember

# This won't work, PowerShell will ask for a value:
Get-ADUser -Filter {City -eq 'London'} | Add-ADGroupMember "London Users" 

# This won't work, PowerShell generate an error because it cannot match
# the output of Get-ADUser to the required input:
Get-ADUser -Filter {City -eq 'London'} | Add-ADGroupMember "London Users" -Members 

Get-ADGroup "London Users" | Add-ADGroupMember -Members (Get-ADUser -Filter {City -eq 'London'})

Get-ADGroupMember "London Users"

<# Remove user from group and remove group
Get-ADGroup "London Users" | Remove-ADGroupMember -Members (Get-ADUser -Filter {City -eq 'London'}) -Confirm:$False
Remove-ADGroup "London Users" -Confirm:$False
#>
