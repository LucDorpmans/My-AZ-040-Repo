# Demonstration: Implicit remoting

$dc = New-PSSession LON-DC1

Get-Module -PSSession $dc -ListAvailable

Import-Module -PSSession $dc -Name ActiveDirectory -Prefix Rem

Help Get-RemADUser
# and note that the server may not have updated help, 
# so the help you get may be truncated and include only the Syntax section

Get-RemADUser -filter *

$dc | Remove-PSSession

Get-RemADUser -filter *
# and note that NO error is displayed, instead a new session is createdon the fly!

