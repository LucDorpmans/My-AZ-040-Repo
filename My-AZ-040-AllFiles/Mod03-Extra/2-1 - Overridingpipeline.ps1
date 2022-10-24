# Demonstration: Overriding the pipeline

Start-Process Notepad -WindowStyle Minimized

# Here Stop-Process receives the parameter 'Name' from the pipeline 
Get-Process -Name Notepad | Stop-Process

# Here Stop-Process the parameter 'Name' is provided as a parameter
Stop-Process -Name Notepad

# This will generate an error because Stop-Process receives the parameter 'Name' 
# from the pipeline as well as it beeing provided as a parameter
Get-Process -Name Notepad | Stop-Process -Name Notepad

