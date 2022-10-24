#########################################################################
# AZ-040-Mod7-Lab: Lab answer key: Using scripts with PowerShell

#############################################################
# Exercise 1: Signing a script
################################

###
# Task 1: Install a code signing certificate
# On AZ-040T00A-LON-CL1, select Start, Enter mmc.exe, and then select mmc.exe.
# In the MMC console, select File, and then select Add/Remove Snap-in.
# In the Add or Remove Snap-ins window, select Certificates, and then select Add.
# In the Certificates snap-in dialog box, select My user account, and then select Finish.
# In the Add or Remove Snap-ins window, select OK.
# In the MMC console, expand Certificates - Current User, and then select Personal.
# Right-click Personal or activate its context menu, hover over All Tasks, and then select Request New Certificate.
# In the Certificate Enrollment wizard, on the Before You Begin page, select Next.
# On the Select Certificate Enrollment Policy page, select Active Directory Enrollment Policy, and then select Next.
# On the Request Certificates page, select the Adatum Code Signing checkbox, and then select Enroll.
# On the Certificate Installation Results page, select Finish.
# In the MMC console, expand Personal, and then select Certificates to verify that the new code signing certificate is present.
# Close the MMC console and select No at the prompt to save the console settings.

###
# Task 2: Digitally sign a script
Get-ChildItem Cert:\CurrentUser\My\ -CodeSigningCert
$cert = Get-ChildItem Cert:\CurrentUser\My\ -CodeSigningCert
Set-Location E:\Mod07\Labfiles
Rename-Item HelloWorld.txt HelloWorld.ps1
Set-AuthenticodeSignature -FilePath HelloWorld.ps1 -Certificate $cert


# Task 3: Set the execution policy
Set-ExecutionPolicy AllSigned

# At the Windows PowerShell prompt, enter the following command, and then press the Enter key. 
# You might be asked if you want to run software from the untrusted publisher. 
# Enter A and then press the Enter key:
.\HelloWorld.ps1

# At the Windows PowerShell prompt, enter the following command, and then press the Enter key. 
# Enter Y at the prompt and press the Enter key:
Set-ExecutionPolicy Unrestricted

#####################################################
# Exercise 2: Processing an array with a ForEach loop
#####################################################
###
# Task 1: Create a test group

# On AZ-040T00A-LON-CL1:
New-ADGroup -Name IPPhoneTest -GroupScope Universal -GroupCategory Security
Move-ADObject "CN=IPPhoneTest,CN=Users,DC=Adatum,DC=com" -TargetPath "OU=IT,DC=Adatum,DC=com"
Add-ADGroupMember IPPhoneTest -Members Abbi,Ida,Parsa,Tonia

###
# Task 2: Create a script to configure the ipPhone attribute

# A script that performs this task is:
. E:\Mod07\Labfiles\AZ-040_Mod07_Ex2_LAK.txt.

#####################################################
# Exercise 3: Processing items by using If statements
#####################################################
###
# Task 1: Create services.txt with service names
Set-Location E:\Mod07\Labfiles
New-Item services.txt -ItemType File
Get-Service "Print Spooler" | Select-Object -ExpandProperty Name | Out-File services.txt -Append
Get-Service "Windows Time" | Select-Object -ExpandProperty Name | Out-File services.txt -Append

###
# Task 2: Create a script that starts stopped services
# A script that performs this task is:
. E:\Mod07\Labfiles\AZ-040_Mod07_Ex3_LAK.txt.

################################################
# Exercise 4: Creating users based on a CSV file
################################################
###
# Task 1: Create AD DS users from a CSV file
# A script that performs this task is:
. E:\Mod07\Labfiles\AZ-040_Mod07_Ex4_LAK.txt.

#############################################################
# Exercise 5: Querying disk information from remote computers
#############################################################
###
# Task 1: Create a script that queries disk information with current credentials
# Perform all steps using AZ-040T00A-LON-CL1.
# A script that performs this task is:
. E:\Mod07\Labfiles\AZ-040_Mod07_Ex5_LAK.txt.

##############################################################
# Exercise 6: Updating the script to use alternate credentials
##############################################################
###
# Task 1: Update the script to use alternate credentials
# A script that performs this task is:
. E:\Mod07\Labfiles\AZ-040_Mod07_Ex6_LAK.txt.


# End of Mod 7 Lab