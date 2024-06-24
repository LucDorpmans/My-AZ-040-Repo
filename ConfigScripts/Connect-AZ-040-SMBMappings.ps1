Get-SmbMapping | Remove-SmbMapping -Force

# $MyRepo = "My-AZ-040-Repo-main"
If (Test-Path E: ) {
    $VolE = Get-Volume -DriveLetter "E" -EA SilentlyContinue
    If (!($Vole.DriveType -eq "Fixed")) { 
        New-SmbMapping -LocalPath E: -RemotePath \\LON-DC1\MyRepo\LabFiles.org\LON-CL1 
    }
}
Get-SmbMapping | Remove-SmbMapping -Force
# New-SmbMapping -LocalPath E: -RemotePath \\LON-DC1\MyFiles\LabFiles.org\LON-CL1
New-SmbMapping -LocalPath F: -RemotePath \\LON-DC1\MyAllFiles
New-SmbMapping -LocalPath G: -RemotePath \\LON-DC1\MyLabFiles
#

# Get-SmbMapping