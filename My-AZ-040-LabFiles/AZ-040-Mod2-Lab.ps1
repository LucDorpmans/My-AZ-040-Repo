#########################################################################
# AZ-040-Mod2-Lab: Performing local system administration with PowerShell

############################################################
# Exercise 1: Creating and managing Active Directory objects
################################

# Task 1: Create a new organizational unit (OU) for a branch office
New-ADOrganizationalUnit -Name London

# Task 2: Create a group for branch office administrators
New-ADGroup "London Admins" -GroupScope Global

# Task 3: Create a user and computer account for the branch office
New-ADUser -Name Ty -DisplayName "Ty Carlson" 
Add-ADGroupMember "London Admins" -Members Ty
New-ADComputer LON-CL2

# Task 4: Move the group, user, and computer accounts to the branch office OU
Move-ADObject -Identity "CN=London Admins,CN=Users,DC=Adatum,DC=com" -TargetPath "OU=London,DC=Adatum,DC=com"
Move-ADObject -Identity "CN=Ty,CN=Users,DC=Adatum,DC=com" -TargetPath "OU=London,DC=Adatum,DC=com"
Move-ADObject -Identity "CN=LON-CL2,CN=Computers,DC=Adatum,DC=com" -TargetPath "OU=London,DC=Adatum,DC=com"

############################################################
# Exercise 2: Configuring network settings on Windows Server
################################
# Task 1: Test the network connection and review the configuration
# Switch to AZ-040T00A-LON-SVR1 Login with adatum\administrator and Pa55w.rd .
Test-Connection LON-DC1
Get-NetIPConfiguration
# Note: Note the IP address, default gateway and Domain Name System (DNS) server for AZ-040T00A-LON-SVR1.

# Task 2: Change the server IP address
New-NetIPAddress -InterfaceAlias Ethernet -IPAddress 172.16.0.15 -PrefixLength 16
Remove-NetIPAddress -InterfaceAlias Ethernet -IPAddress 172.16.0.11

# Task 3: Change the DNS settings and default gateway for the server
Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddress 172.16.0.12
Remove-NetRoute -InterfaceAlias Ethernet -DestinationPrefix 0.0.0.0/0 -Confirm:$false
# In the console window, enter the following command, and then press the Enter key.

New-NetRoute -InterfaceAlias Ethernet -DestinationPrefix 0.0.0.0/0 -NextHop 172.16.0.2

# Task 4: Verify and test the changes
# On AZ-040T00A-LON-SVR1, 
Get-NetIPConfiguration
# Note: Note the IP address, default gateway, and DNS server.

Test-Connection LON-DC1
# Note: Following the change, it should take longer to receive a response from AZ-040T00A-LON-DC1. 
# The actual delay might vary. While the change should be large enough to be noticeable, 
# it's possible you won't notice much difference.

################################
# Exercise 3: Creating a website
################################
# Task 1: Install the Web Server (IIS) role on the server
# On AZ-040T00A-LON-SVR1, 
Install-WindowsFeature Web-Server
# Note: Wait for Internet Information Services (IIS) to install. This should take about 2 minutes.

# Task 2: Create a folder on the server for the website files
New-Item C:\inetpub\wwwroot\London -Type directory

# Task 3: Create the IIS website
New-IISSite London -PhysicalPath C:\inetpub\wwwroot\London -BindingInformation "172.16.0.15:8080:"

# Start Edge(!)
#In the Address bar, enter 
http://172.16.0.15:8080

# Note: Internet Explorer displays an error message that the web server is configured to not list the contents of this directory. The error message details give the physical path of the site, which should be C:\inetpub\wwwroot\London.
# End of Mod 2 Lab
