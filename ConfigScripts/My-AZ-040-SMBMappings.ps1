Get-SmbMapping | Remove-SmbMapping -Force
New-SmbMapping -LocalPath E: -RemotePath \\LON-DC1\MyFiles\LabFiles.org\LON-CL1
New-SmbMapping -LocalPath F: -RemotePath \\LON-DC1\MyFiles\My-AZ-040-AllFiles
New-SmbMapping -LocalPath G: -RemotePath \\LON-DC1\MyFiles\My-AZ-040-LabFiles
New-SmbMapping -LocalPath H: -RemotePath \\LON-DC1\MyFiles

# Get-SmbMapping