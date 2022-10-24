# Demonstration: Importing data

$BasePath = "E:\10961C-ENU-Allfiles-PS1"

#Use Get-Content to import data from a text file
Get-Content "$BasePath\Mod08\computers.txt"
PSEdit "$BasePath\Mod08\computers.txt"
$computers = Get-Content "$BasePath\Mod08\computers.txt"
$computers.count
$computers

#Use Import-Csv to import data from a .csv file
Import-Csv "$BasePath\Mod08\users.csv"

$users = Import-Csv "$BasePath\Mod08\users.csv"
$users.count
$users[0]
$users[0].First

#Use Import-Clixml to import data from an XML file
Import-Clixml 
PSEdit "$BasePath\Mod08\users.xml"
$usersXml = Import-Clixml "$BasePath\Mod08\users.xml"
$usersXml.count
$usersXml[0].Department
$usersXml | Get-Member

Get-Service | Export-Clixml "$BasePath\Services.xml"
$Svc = Import-Clixml Services.xml
$Svc

