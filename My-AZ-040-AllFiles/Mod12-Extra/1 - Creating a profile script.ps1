# Demonstration: Creating a profile script

#region Manual:
# In File Explorer, in the navigation pane, under Quick Access, click Documents.
# Click the Home tab, click New Folder, type WindowsPowerShell, and then press Enter.
# Double-click WindowsPowerShell.
# Click the Home tab, click New Item, and then click Text Document.
# Clear the existing name, type Profile.ps1, and then press Enter.
# In the Rename dialog box, click Yes.
# Right-click Profile.ps1, and then click Edit.
# In the Windows PowerShell ISE, type $servers=”LON-DC1”,”LON-SVR1”.
# Click the File menu, and then click Save.
# Close the Windows PowerShell ISE.
#endregion

#region Or...
Set-Location $ENV:HomeDrive\$ENV:HomePath\Documents
New-Item WindowsPowerShell -ItemType Directory
Set-Location $ENV:HomeDrive\$ENV:HomePath\Documents\WindowsPowerShell
New-Item Profile.ps1 -ItemType File
PSEdit .\Profile.ps1
# In the Windows PowerShell ISE tab , type $servers=”LON-DC1”,”LON-SVR1”.
#endregion

#region Or even better
$Profile
New-Item $ENV:HomeDrive\$ENV:HomePath\Documents\WindowsPowerShell\Profile.ps1 -ItemType File -Force
'$servers=”LON-DC1”,”LON-SVR1”' > $Profile
#endregion
