# Demonstration: Managing users and groups

New-ADGroup -Name HelpDesk -Path "OU=IT,DC=Adatum,DC=com" –GroupScope Global

New-ADUser -Name "Jane Doe" -Department "IT"

Add-ADGroupMember "HelpDesk" -Members "Lara","Jane Doe"

Get-ADGroupMember HelpDesk 

Set-ADuser Lara -StreetAddress "1530 Nowhere Ave." -City "Winnipeg" -State "Manitoba" -Country "CA"

Get-ADPrincipalGroupMembership "Jane Doe"

Get-ADuser Lara -Properties StreetAddress,City,State,Country


