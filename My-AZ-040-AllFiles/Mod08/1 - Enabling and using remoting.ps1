# Demonstration: Enabling and using remoting

# On LON-CL1 execute the following:
Set-ExecutionPolicy RemoteSigned
Enable-PSRemoting
# If you get an error about a network connection being Public, 
# run Enable-PSRemoting -SkipNetwork instead. 
# Point out the error to students - it's one they'll see a lot.

# From LON-CL1 of LON-SVR1
Enter-PSSession -ComputerName LON-DC1
Get-Process
Exit-PSSession

# From LON-SVR1 only
Invoke-Command -ComputerName LON-SVR1,LON-DC1 -ScriptBlock { Get-EventLog -LogName Security -Newest 10 }
