# Demonstration: Invoking methods of repository objects

Invoke-CimMethod -ComputerName LON-SVR1 -ClassName Win32_OperatingSystem -MethodName Reboot

Start-Process Mspaint -WindowStyle Minimized

Get-CimInstance -Class Win32_Process -Filter "Name='mspaint.exe'" | Invoke-CimMethod -Name Terminate

(Get-Process MSPaint).Kill()