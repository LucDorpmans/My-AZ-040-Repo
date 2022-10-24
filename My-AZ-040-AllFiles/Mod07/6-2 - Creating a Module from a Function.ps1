# Demonstration: Creating a module from a function
#In this demonstration, you will see how to create a module.

#Demonstration steps:
# Open a Windows PowerShell prompt.
Set-Location F:\Mod09\

# To copy and rename a script file, at the Windows PowerShell prompt, type the following command, and then press Enter:
Copy-Item .\"6-1 - Creating a Function in a Script.ps1" .\FolderFunctions.psm1

# Open Windows PowerShell ISE and open FolderFunctions.psm1.
# Remove the last two lines that call the function and save the file.
# To create a folder for the module, at the Windows PowerShell prompt, type the following command, and then press Enter:
New-Item -Type Directory "C:\Program Files\WindowsPowerShell\Modules\FolderFunctions"

# To copy the .psm1 file, at the Windows PowerShell prompt, type the following command, and then press Enter:
Copy-Item .\FolderFunctions.psm1 "C:\Program Files\WindowsPowerShell\Modules\FolderFunctions"

# To verify that the module is recognized, at the Windows PowerShell prompt, type the following command, and then press Enter:
Get-Module -ListAvailable F*

# To verify that the module is not loaded, at the Windows PowerShell prompt, type the following command, and then press Enter:
Get-Module

# To use the function in the module, at the Windows PowerShell prompt, type the following command, and then press Enter:
Get-FolderSize -Path C:\Windows

# To verify that the module is loaded, at the Windows PowerShell prompt, type the following command, and then press Enter:
Get-Module

# Close Windows PowerShell ISE and the Windows PowerShell prompt.