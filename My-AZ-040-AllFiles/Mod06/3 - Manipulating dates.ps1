# Demonstration: Manipulating dates

#Place the current date in a variable
$date = Get-Date

#View date properties
$date
$date.Hour
$date.Minute
$date.Day
$date.DayOfWeek
$date.Month
$date.Year

#Add or subtract time from a date
$date.AddDays(100)
$date.AddDays(-60)

#Long and short formats
$date.ToLongDateString()
$date.ToShortDateString()
$date.ToLongTimeString()
$date.ToShortTimeString()

# Get-Data -Format geeft tekst als uitvoer
Get-Date -Format "dd-MM-yyyy"
Get-Date -Format o

# Als de datum al in een variable staat, kan je de -f format operator gebruiken
$MyDatum = Get-Date
"{0:yyyy}.{0:MM}.{0:dd} @ {1:}" -f ($MyDatum), "LON-HOST"
"{0:hh}:{0:mm}" -f (Get-Date)
