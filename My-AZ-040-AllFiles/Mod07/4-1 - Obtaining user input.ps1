# Demonstration: Obtaining user input

# Use Read-Host to obtain user input
$days = Read-Host "Enter the number of days"
$days

#Use Get-Credential to obtain and store a credential
$cred = Get-Credential
$cred | Format-List

$cred = Get-Credential "ADATUM\Administrator"
# "Safely" store password in file
$cred | Export-Clixml -Path F:\Mod07\cred.xml 


# Decrypt Powershell SecureString Password
$StoredCred = Import-Clixml F:\Mod07\cred.xml
$Storedcred.GetNetworkCredential() | Get-Member
$Storedcred.GetNetworkCredential().password
# Start-process https://devblogs.microsoft.com/scripting/decrypt-powershell-secure-string-password/


# Use Out-Gridview to obtain a user selection
Get-ADComputer -Filter * | Out-GridView
$computers = Get-ADComputer -Filter * 
$Choice = $computers | Out-GridView  -PassThru
$Choice 

$computer = Get-ADComputer -Filter * | Out-GridView
$computer
