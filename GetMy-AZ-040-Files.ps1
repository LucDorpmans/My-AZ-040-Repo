# GetMy-AZ-040-Files.ps1
Function Get-MyScript { Param( [string]$AFile,[switch]$EditFile = $False, 
							   [string]$SPath = "$env:USERPROFILE\Downloads\")
			Invoke-Webrequest -Uri "https://raw.githubusercontent.com/LucDorpmans/My-AZ-040-Repo/main/$AFile"  -Outfile "$SPath$AFile" 
			If ($EditFile) { PSEdit ("$SPath$AFile" )} }

Get-MyScript "PowerShell-Core-7-Download+Install.ps1" -EditFile
Get-MyScript "Edge-HideFirstRunExperience.ps1" -EditFile
Get-MyScript  "WinX-CmdNotPowerShell.ps1" -EditFile
Get-MyScript  "AddRSATToolsList-Win1x.ps1" -EditFile
Get-MyScript  "GitHub-Desktop-Download+SilentInstall.ps1" -EditFile
            
Function DownloadFilesFromRepo {
# https://gist.github.com/chrisbrownie/f20cb4508975fb7fb5da145d3d38024a
Param(
    [string]$Owner,
    [string]$Repository,
    [string]$Path,
    [string]$DestinationPath
    )

    $baseUri = "https://api.github.com/"
    $args = "repos/$Owner/$Repository/contents/$Path"
    $wr = Invoke-WebRequest -Uri $($baseuri+$args)
    $objects = $wr.Content | ConvertFrom-Json
    $files = $objects | where {$_.type -eq "file"} | Select -exp download_url
    $directories = $objects | where {$_.type -eq "dir"}
    
    $directories | ForEach-Object { 
        DownloadFilesFromRepo -Owner $Owner -Repository $Repository -Path $_.path -DestinationPath $($DestinationPath+$_.name)
    }

    
    if (-not (Test-Path $DestinationPath)) {
        # Destination path does not exist, let's create it
        try {
            New-Item -Path $DestinationPath -ItemType Directory -ErrorAction Stop
        } catch {
            throw "Could not create path '$DestinationPath'!"
        }
    }

    foreach ($file in $files) {
        $fileDestination = Join-Path $DestinationPath (Split-Path $file -Leaf)
        try {
            Invoke-WebRequest -Uri $file -OutFile $fileDestination -ErrorAction Stop -Verbose
            "Grabbed '$($file)' to '$fileDestination'"
        } catch {
            throw "Unable to download '$($file.path)'"
        }
    }

}


DownloadFilesFromRepo -Owner "LucDorpmans" -Repository My-AZ-040-Repo -DestinationPath C:\Scripts\Github\

