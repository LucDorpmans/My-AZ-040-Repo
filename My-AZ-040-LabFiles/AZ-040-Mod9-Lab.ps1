#########################################################################
# AZ-040-Mod9-Lab: Azure resource management with PowerShell

#############################################################
# Exercise 1: Activating the Azure subscription and installing the PowerShell Az module
################################
# Log in to AZ-040T00A-LON-CL1 with Username: adatum\administrator and Password: Pa55w.rd
# The Lab Files can be found # In the All Files\ E: # On the AZ-040T00A-LON-CL1 VM

###
# Task1: Sign in to your Cloudslice Subscription
# On AZ-040T00A-LON-CL1, open the Microsoft Edge browser and navigate to https://www.portal.azure.com.
# Sign in with 
Username: User1-26483169@LODSPRODMSLEARNMCA.onmicrosoft.com and 
Password: Pb4Jg2!@Aa
# Task2: Install the Azure Az module for PowerShell
# Select the Start menu, and then Enter pwsh.
# In the results list, right-click PowerShell 7 (x64) or activate its context menu, and select Run as administrator.
# In the Administrator: PowerShell 7 (x64) window, enter the following command, and then press the Enter key to check your PowerShell version:$PSVersionTable.PSVersion
# To set your execution policy to the proper value so you can install the Az module, enter the following command, and then press the Enter key. Enter Y to confirm your choice:Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# To install the Az module:Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force
# Wait until the module is installed and the command prompt displays.
# After the Az module is installed:
Connect-AzAccount
# When prompted, sign in with the account that you used # In the previous # Taskto provision your Azure subscription.
# Verify that after sign-in, your account name and the Azure subscription details are listed.

#####################################
# Exercise 2: Using Azure Cloud Shell
#####################################
###
# Task1: Use Azure Cloud Shell to create a resource group
# On the AZ-040T00A-LON-CL1 computer, switch to the web browser window displaying the Azure portal at https://portal.azure.com.
# On the Microsoft Azure portal homepage, select Virtual Machines. Ensure that no virtual machines (VMs) are created. Select Home.
# On the Microsoft Azure portal homepage, select Storage accounts. Ensure that no storage accounts are created. Select Home.
# On the Microsoft Azure portal homepage, select the Cloud Shell icon.
# In the Welcome to Azure Cloud Shell window, select PowerShell.
# On the You have no storage mounted page, review the note about the missing storage account that's needed for Cloud Shell to run. Verify that # In the Subscription field, your subscription is selected, and then select Create storage. Wait until the storage account is created.
# When your storage account is created, the Cloud Shell console should open, and you should get a prompt # In the format PS /home/user1-26483169>.
# At the PowerShell prompt, Enter Get-AzSubscription, and then press the Enter key to review your subscriptions.
# Enter 
Get-AzResourceGroup 
# to review the resource group information.

# Use the drop-down list to switch from PowerShell to the Bash shell and confirm your choice.
# At the Bash shell prompt, Enter az account list, and then press the Enter key to review the information about your subscription. Also, try tab completion.
# Enter 
az resource list 
# to review the resource group information.
# Switch back to the PowerShell interface.

# In the PowerShell console, enter the following command, and then press the Enter key to create a new resource group:New-AzResourceGroup -Name ResourceGroup1 -Location eastus
# Verify that your new resource group is created. Record the name of your resource group. You will need it # In the next exercise of this lab.

# Exercise 3: Managing Azure resources with Azure PowerShell
# Task1: Create an Azure VM by using PowerShell
# In the Windows PowerShell window, enter the following command to provide the admin credentials for the operating system of the Azure VM you will create in this exercise:$cred = Get-Credential -Message "Enter an admin username and password for the operating system"
# When prompted, enter an arbitrary username and password that you want to use as admin credentials for the new VM. Do not use Admin or Administrator as the username. 
# Choose a complex, at least 8 character-long password # that includes lower case letters, 
# upper case letters, digits, and at least one special character.

# In the Windows PowerShell window, enter the following command to define the VM parameters, and then press the Enter key (replace the <resource-group-name> placeholder with the name of the resource group you created # In the previous exercise):$vmParams = @{
 ResourceGroupName = 'ResourceGroup1'
 Name = 'TestVM1'
 Size = 'Standard_D2s_v3'
 Location = 'eastus'
 ImageName = 'Win2019Datacenter'
 PublicIpAddressName = 'TestPublicIp'
 Credential = $cred
 OpenPorts = 3389
}

# To create a new VM based on these parameters and store the reference to it # In the newVM1 variable:$newVM1 = New-AzVM @vmParams
# Note: Wait until the Azure VM is created.
# To identify the configuration settings of the new VM, enter the following commands, and then press the Enter key after each:
$NewVM1
$newVM1.OSProfile | Select-Object ComputerName,AdminUserName
$newVM1 | Get-AzNetworkInterface | Select-Object -ExpandProperty IpConfigurations | Select-Object Name,PrivateIpAddress

# To retrieve the name of the resource group into which you deployed the Azure VM and store it in a variable:$rgName = $NewVM1.ResourceGroupName
# To identify the public IP address assigned to the network interface of the Azure VM so you can connect to it, enter the following commands:$publicIp = Get-AzPublicIpAddress -Name TestPublicIp -ResourceGroupName $rgName
$publicIp | Select-Object Name,IpAddress,@{label='FQDN';expression={$_.DnsSettings.Fqdn}}
# Note the value of IPAddress # In the table output.

# Enter the following command, and then press the Enter key to connect to the VM by using Remote Desktop:mstsc.exe /v $publicIp.IpAddress
# When prompted, sign in with the admin credentials you provided during the Azure VM provisioning. Ensure that you're connected to the Windows Server 2019 VM and then shut down the operating system. This will automatically terminate your Remote Desktop session.

###
# Task2: Add a disk to the Azure VM by using PowerShell
# On the AZ-040T00A-LON-CL1 computer, switch to the web browser window displaying the Azure portal and navigate to the Virtual Machines page.

# On the Virtual Machines page, select the TestVM1 entry.

# On the Overview page of the TestVM1 VM, review its parameters and, # In the navigation menu, # In the Settings section, select Disks.

Review the list of disks and verify that only a single disk is listed (OS disk).

# To create a data disk for the existing VM, # In the Windows PowerShell window, enter the following commands, and press the Enter key after each:
$VirtualMachine = Get-AzVM -ResourceGroupName ResourceGroup1 -Name "TestVM1"

Add-AzVMDataDisk -VM $VirtualMachine -Name "disk1" -LUN 0 -Caching ReadOnly -DiskSizeinGB 1 -CreateOption Empty

Update-AzVM -ResourceGroupName ResourceGroup1 -VM $VirtualMachine
Switch to the Azure portal and refresh the TestVM1 | Disks page. Verify that the listing of disks includes a new disk called disk1 # In the Data disks section.

# Task3: Delete the Azure resources
# On the AZ-040T00A-LON-CL1 computer, switch back to the PowerShell window.

# # In the PowerShell console, enter the following command, and then press the Enter key to delete the resource group and all of its resources, which you created earlier in this lab:Remove-AzResourceGroup -Name $rgName -Force
# Wait for the command to complete. This should take less than 5 minutes.


# End of Mod 9 Lab
