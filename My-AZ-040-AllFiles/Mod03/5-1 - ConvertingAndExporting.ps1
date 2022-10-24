# Demonstration: Exporting data 

Get-Service | ConvertTo-CSV | Out-File E:\Services.csv 
# or 
Get-Service | Export-CSV E:\Services.csv
PSEdit E:\Services.csv

Get-Service | ConvertTo-HTML | Out-File E:\Services.html
Invoke-Expression E:\Services.html
PSEdit E:\Services.html

Get-Service | Export-CliXML E:\Services.xml
PSEdit E:\Services.xml
Invoke-Expression E:\Services.xml

Get-Service | ConvertTo-JSON > E:\Services.json
PSEdit E:\Services.json

