# Demonstration: Creating calculated properties

Get-ADuser -Filter * -Properties whenCreated

Get-ADuser -Filter * -Properties whenCreated | Sort-Object -Property whenCreated -Descending
#Fout !
Get-ADUser -Filter * -Properties whenCreated | 
    Sort-Object -Property whenCreated -Descending | 
    Select-Object -Property Name,@{n='Account age (days)';e={$PSItem.whenCreated.Day-{Get-Date}.Day}}

# Goed
Get-ADUser -Filter * -Properties whenCreated | 
    Sort-Object -Property whenCreated -Descending | 
    Select-Object -Property Name, `
        @{
            n='Account age (days)';
            e={(New-TimeSpan -Start $PSItem.whenCreated).days}
        }


(New-TimeSpan -Start (Get-ChildItem .\out.txt).CreationTime ).Days


