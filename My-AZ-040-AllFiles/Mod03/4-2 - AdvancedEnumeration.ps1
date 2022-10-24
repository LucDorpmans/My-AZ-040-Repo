# Demonstration: Advanced enumeration

Get-ItemProperty -Path HKCU:\Network\* | 
    ForEach-Object -Process { Set-ItemProperty -Path $PSItem.PSPath -Name RemotePath -Value $PSItem.RemotePath.ToUpper() }


Get-ChildItem E:\ -Directory -recurse | 
    Where-Object Name -eq Democode | 
    ForEach-Object {$PSItem.CreateSubdirectory('Test')} | 
    Select-Object FullName

# Dit werkt NIET als er files of subdirectories in de folders staan
Get-ChildItem E:\ -Directory -recurse | 
    Where-Object Name -eq Test | 
    ForEach-Object {$PSItem.Delete()} 

Copy-Item "E:\Mod07\Democode\10961C_Mod01_Demo*.txt" "E:\Mod07\Democode\Test\"
Copy-Item "E:\Mod12\Democode\10961C_Mod01_Demo*.txt" "E:\Mod12\Democode\Test\"


# Dit werkt ook als er files in de folders staan...
Get-ChildItem E:\ -Directory -recurse | 
    Where-Object Name -eq Test | 
    ForEach-Object {$PSItem.Delete(1)} 


Get-ChildItem E:\ -Directory -recurse | 
    Where-Object        Name -eq Test | 
    ForEach-Object {$PSItem.FullName} 
