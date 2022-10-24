# Demonstration: Setting the script execution policy

#Verify script location
Set-Location F:\Mod08
Rename-Item .\HelloWorld.txt -NewName HelloWorld.ps1
Get-ChildItem HelloWorld.ps1

#Run a script using a full path
F:\Mod08\HelloWorld.ps1

#Run a script fromt the current directory
psedit HelloWorld.ps1
.\HelloWorld.ps1

#Set the execution policy
Get-ExecutionPolicy
Set-ExecutionPolicy RemoteSigned # Dit werkt niet met de gekozen (Internet) Security instellingen op LON-CL1
# Dus of deze instellingen aanpassen, of AllSigned gebruiken...
Set-ExecutionPolicy AllSigned

\\LON-DC1\10961C-ENU-ALLFILES-PS1\Mod08\HelloWorld.ps1
Set-ExecutionPolicy Unrestricted -Force