# Demonstration: Using Aliases 

dir

Get-ChildItem

Get-Alias dir

New-Alias list Get-ChildItem

list

Get-Alias -definition Get-ChildItem
