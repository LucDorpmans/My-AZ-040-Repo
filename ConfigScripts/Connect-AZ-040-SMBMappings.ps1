Get-SmbMapping | Remove-SmbMapping -Force

$MyRepo = "My-AZ-040-Repo-main"
$VolE = Get-Volume -DriveLetter "E" -EA SilentlyContinue
If (!($Vole.DriveType -eq "Fixed")) { New-SmbMapping -LocalPath E: -RemotePath \\LON-DC1\MyRepo\LabFiles.org\LabFiles.CL1 }
New-SmbMapping -LocalPath F: -RemotePath \\LON-DC1\MyRepo\My-AZ-040-AllFiles
New-SmbMapping -LocalPath G: -RemotePath \\LON-DC1\MyRepo\My-AZ-040-LabFiles
New-SmbMapping -LocalPath H: -RemotePath \\LON-DC1\MyRepo

# Get-SmbMapping