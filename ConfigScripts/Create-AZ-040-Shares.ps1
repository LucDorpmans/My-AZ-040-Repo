Get-SmbShare MyAllFiles | Remove-SmbShare -Confirm:$false
Get-SmbShare MyLabFiles | Remove-SmbShare -Confirm:$false

New-SmbShare -Name MyFiles -Path E:\MyFiles
New-SmbShare -Name MyAllFiles -Path E:\MyFiles\My-AZ-040-AllFiles
New-SmbShare -Name MyLabFiles -Path E:\MyFiles\My-AZ-040-LabFiles