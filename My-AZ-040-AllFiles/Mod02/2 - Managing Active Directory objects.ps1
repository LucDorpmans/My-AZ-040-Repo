# Demonstration: Managing Active Directory objects

New-ADObject -Name JohnSmithcontact -Type contact -DisplayName “John Smith (Contoso.com)”

Get-ADObject -Filter 'ObjectClass -eq "contact"'

Set-ADObject -Identity "CN=Lara Raisic,OU=IT,DC=Adatum,DC=com" -Description “Member of support team”

Get-ADUser Lara -Properties Description

Rename-ADObject -Identity "CN=Helpdesk,OU=IT,DC=Adatum,DC=com" -NewName SupportTeam

Get-ADGroup -Filter 'Name -eq "SupportTeam"'

Get-ADGroup helpdesk 

Get-ADGroup helpdesk | Set-ADGroup -SamAccountName "SupportTeam"

Get-ADGroup SupportTeam
