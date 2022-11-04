#########################################################################
# AZ-040-Mod10-Lab: Managing Microsoft 365 with PowerShell

###################################################
# Exercise 1: Managing users and groups in Azure AD
###################################################

# Lab Files
# All VM logins can be found on the Resources Tab above the Instructions pane.
# Log in to AZ-040T00A-LON-CL1 with Username: adatum\administrator and Password: Pa55w.rd
# These can be found in the All Files\ E: on the AZ-040T00A-LON-CL1 VM

# Task 1: Connect to Azure AD
# On AZ-040T00A-LON-CL1:
# To install the AzureAD module, in the Administrator: Windows PowerShell console, enter the following command, and then press the Enter key (when prompted for confirmation, Enter Y and press the Enter key again twice in a row):
Install-Module AzureAD

# To connect to Azure AD:
Connect-AzureAD

# In the Sign in to your account window, enter the name of the user account with the Global Administrator role in the Azure Active Directory (Azure AD) tenant you will be using in this lab, and then select Next.
# At the Enter password prompt, enter your password: gpOr3!1Yu@@x, and then select Sign in.

# To review a list of users in Azure AD:
Get-AzureADUser

###
# Task 2: Create a new administrative user
# To create a password profile object, in the Administrator: Windows PowerShell console:
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
# Identify an arbitrary but complex password that you want to use for a new user and record it since you will need it later in this lab. Make sure that the password is at least 8 characters-long, including a combination of lower case letters, upper case letters, digits, and at least one special character. In the next step, replace <password> with the password you decided to use.

# To set the password property of the password profile object:
$PasswordProfile.Password = "P@ssw0rd1234"

# To create a new Azure AD user, enter the following commands:
$verifiedDomain = (Get-AzureADTenantDetail).VerifiedDomains[0].Name
New-AzureADUser -DisplayName "Noreen Riggs" -UserPrincipalName Noreen@$verifiedDomain -AccountEnabled $true -PasswordProfile $PasswordProfile -MailNickName Noreen

# To store a reference to the new user object in a variable:
$user = Get-AzureADUser -ObjectID Noreen@$verifiedDomain

# To store a reference to the Global Administrator role in a variable:
$role = Get-AzureADDirectoryRole | Where-Object {$_.displayName -eq 'Global Administrator'}

# To assign the Global Administrator role to Noreen's user account:
Add-AzureADDirectoryRoleMember -ObjectId $role.ObjectId -RefObjectId $user.ObjectID

# To verify that the Global Administrator role was assigned to Noreen's user account:
Get-AzureADDirectoryRoleMember -ObjectId $role.ObjectId
# In the output of the command, identify the UserPrincipalName attribute of Noreen's user account and record it. You will need it in one of the later exercises of this lab.

###
# Task 3: Create and license a new user

# To create another Azure AD user, in the Administrator: Windows PowerShell console:
New-AzureADUser -DisplayName "Allan Yoo" -UserPrincipalName Allan@$verifiedDomain -AccountEnabled $true -PasswordProfile $PasswordProfile -MailNickName Allan

# To set the location property of the newly created user account:
Set-AzureADUser -ObjectId Allan@$verifiedDomain -UsageLocation US

# To review the available licenses in the tenant:
Get-AzureADSubscribedSku | Format-List

# To store the SKU ID for the intended license in a variable:
$SkuId = (Get-AzureADSubscribedSku | Where-Object SkuPartNumber -eq "ENTERPRISEPREMIUM").SkuID

# To create an AssignedLicense object:
$License = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense

# To add the SKU ID to the license object:
$License.SkuId = $SkuId

# To create an AssignedLicenses object:
$LicensesToAssign = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses

# To add the AssignedLicense object to the AddLicenses property:
$LicensesToAssign.AddLicenses = $License

# To configure Allan's user object with the AssignedLicenses object:
Set-AzureADUserLicense -ObjectId Allan@$verifiedDomain -AssignedLicenses $LicensesToAssign

###
# Task 4: Create and populate a group
# To review the existing groups:
Get-AzureADGroup

# To create a new security group:
New-AzureADGroup -DisplayName "Sales Security Group" -SecurityEnabled $true -MailEnabled $false -MailNickName "SalesSecurityGroup"

# To store a reference to Sales Security Group in a variable:
$group = Get-AzureAdGroup -SearchString "Sales Security"

# To store a reference to Allan Yoo's user account in a variable:
$user = Get-AzureADUser -ObjectId Allan@$verifiedDomain

# To add Allan Yoo's user account to the Sales Security Group:
Add-AzureADGroupMember -ObjectId $group.ObjectId -RefObjectId $user.ObjectId

# To verify that Allan Yoo's user account is a member of the Sales Security Group:
Get-AzureADGroupMember -ObjectId $group.ObjectId
# In the output of the command, identify the UserPrincipalName attribute of Allan's user account and record it. You will need it in the next exercise.

######################################
# Exercise 2: Managing Exchange Online
######################################
###
# Task 1: Connect to Exchange Online

# To install the ExchangeOnlineManagement module on AZ-040T00A-LON-CL1, in the Administrator: Windows PowerShell console, enter the following command, and then press the Enter key (when prompted for confirmation, Enter A and press the Enter key again):
Install-Module ExchangeOnlineManagement -force

# To connect to Exchange Online:
Connect-ExchangeOnline
# In the Sign in to your account window, enter the name of the same user account you were using in the previous exercise of this lab, and then select Next.
# At the Enter password prompt, enter your password: gpOr3!1Yu@@x, and then select Sign in.

# To review a list of mailboxes in Exchange Online:
Get-EXOMailbox

###
# Task 2: Create a room mailbox
# To create a new room mailbox, in the Windows PowerShell console:
New-Mailbox -Room -Name BoardRoom

# To configure the new room to accept meeting requests:
Set-CalendarProcessing BoardRoom -AutomateProcessing AutoAccept

###
# Task 3: Verify room resource booking
# On AZ-040T00A-LON-CL1, to open the outlook site in Microsoft Edge:
Start-Process https://outlook.office.com
# Sign in as Allan Yoo by using the UserPrincipalName as the user name and providing the password 
# P@ssw0rd1234 
# When prompted, change your password as instructed
# P@ss221104
# Be sure to record the password so that you can use it during subsequent exercises.
# If prompted to stay signed in, select No.
# From the menu bar, select Calendar, and then select New event.
# In the Add a title box, Enter Staff Meeting.
# In the Invite attendees box, Enter BoardRoom, select BoardRoom, select the first available time, and then select Send.
# From the menu, select Mail.
# Verify that Allan has received a response from BoardRoom that the meeting request was accepted.
# Sign out from Allan's user account.

########################################
# Exercise 3: Managing SharePoint Online
########################################
###
# Task 1: Connect to SharePoint Online

# To install the SharePoint Online Management Shell, on AZ-040T00A-LON-CL1, in the Administrator: Windows PowerShell console, enter the following command, and then press the Enter key (when prompted for confirmation, Enter A and press the Enter key again):
Install-Module -Name Microsoft.Online.SharePoint.PowerShell

# To connect to SharePoint Online, enter the following commands:
$verifiedDomainShort = $verifiedDomain.Split(".")[0]
Connect-SPOService -Url "https://$verifiedDomainShort-admin.sharepoint.com"
# When prompted, sign in as Noreen Riggs and change your password as instructed. Be sure to record the password so that you can use it during subsequent exercises.

# To list the existing SharePoint Online sites:
Get-SPOSite

###
# Task 2: Create a new site
# To review the available templates, in the Windows PowerShell console:
Get-SPOWebTemplate

# To create a new site:
New-SPOSite -Url https://$verifiedDomainShort.sharepoint.com/sites/Sales -Owner noreen@$verifiedDomain -StorageQuota 256 -Template EHS#1 -NoWait
# Note: Creating the site can take 10 minutes or longer. 
# The -NoWait parameter performs this task asynchronously, so you don't need to wait for its completion. 
# If you intend to wait, you can verify the status of the SharePoint site by entering the following command, 
# and then pressing the Enter key:
Get-SPOSite | Format-List Url,Status

# To disconnect from SharePoint Online:
Disconnect-SPOService

######################################
# Exercise 4: Managing Microsoft Teams
######################################
###
# Task 1: Connect to Microsoft Teams
# To install the Microsoft Teams PowerShell Module, in the Administrator: Windows PowerShell console, enter the following command, and then press the Enter key (when prompted for confirmation, Enter A and press the Enter key again):
Install-Module MicrosoftTeams -Force

# To connect to Microsoft Teams:
Connect-MicrosoftTeams

# In the Sign in to your account window, select the Use another account option, enter the name of the user account with the Global Administrator role in the Azure Active Directory (Azure AD) tenant you were using in this lab, and then select Next.

# To verify that there are no existing teams:
Get-Team

###
# Task 2: Create a new team

# To create a Sales team, in the Windows PowerShell console:
New-Team -DisplayName "Sales Team" -MailNickName "SalesTeam"

# To place the team information in a variable:
$team = Get-Team -DisplayName "Sales Team"

# To review the information about your team:
$team | Format-List
# Review the information about the Sales Team. Notice that GroupId is a unique identifier.

# To add a user to the team:
Add-TeamUser -GroupId $team.GroupId -User Allan@$verifiedDomain -Role Member

# To review the team users:
Get-TeamUser -GroupId $team.GroupId
# Note: Notice that the user that created the team is an owner.

###
# Task 3: Verify access to the team
# On AZ-040T00A-LON-CL1, to open the Teams website in Microsoft Edge:
Start-Process https://teams.microsoft.com 
# Sign in as Allan Yoo by using the UserPrincipalName as the user name 
# and providing the password you changed earlier in this lab.
# When prompted to stay signed in, select No.
# Close the Bring your team together window, and then verify that Sales Team is listed.
# Select New conversation, Enter Prices are increasing 10% at month end, and then press the Enter key.
# Close Microsoft Edge.

# End of Mod 10 Lab