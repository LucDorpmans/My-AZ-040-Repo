Get-SmbShare MyAllFiles | Remove-SmbShare -Confirm:$false
Get-SmbShare MyLabFiles | Remove-SmbShare -Confirm:$false

$MyRepo = "My-AZ-040-Repo-main"
New-SmbShare -Name MyRepo -Path "E:\$MyRepo" -FullAccess "Adatum\Administrator"
New-SmbShare -Name MyAllFiles -Path "E:\$MyRepo\My-AZ-040-AllFiles" -FullAccess "Adatum\Administrator"
New-SmbShare -Name MyLabFiles -Path "E:\$MyRepo\My-AZ-040-LabFiles" -FullAccess "Adatum\Administrator"