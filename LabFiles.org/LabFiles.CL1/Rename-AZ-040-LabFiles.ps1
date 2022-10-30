$FilePath = "C:\Stack\MCT\!MOC\PowerShell\AZ-040\LabFiles\LON-CL1\AZ-040-LabFiles\"
Get-ChildItem $FilePath -File -Recurse 

Get-ChildItem $FilePath -File -Recurse -Include *.txt | ForEach-Object { Write-Output  $_.Name ; Rename-Item -Path $_.PSPath -NewName $_.Name.replace(".ps1.txt",".ps1") }
Get-ChildItem $FilePath -File -Recurse -Include AZ*.txt | ForEach-Object { Write-Output  $_.Name ; Rename-Item -Path $_.PSPath -NewName $_.Name.replace(".txt",".ps1") }


Get-ChildItem $FilePath -File -Recurse -Include *.ps1.txt | ForEach-Object { Write-Output  $_.Name ; Rename-Item -Path $_.PSPath -NewName $_.BaseName } 