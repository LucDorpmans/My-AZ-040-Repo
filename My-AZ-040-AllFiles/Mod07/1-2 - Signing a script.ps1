# Demonstration: Digitally signing a script

# Request a Code Siging certificate from AdatumCA
Set-Location -Path cert:\CurrentUser\My
Get-Certificate -Template 'AdatumCodeSigning' 

# View the code signing certificates installed for the current user:
Get-ChildItem Cert:\CurrentUser\My\ -CodeSigningCert
Start-Process Cert:\CurrentUser\My\

# Place the code signing certificate in a variable:
$cert = Get-ChildItem Cert:\CurrentUser\My\ -CodeSigningCert

# Sign a script:
Set-AuthenticodeSignature -FilePath F:\Mod08\HelloWorld.ps1 -Certificate $cert

Set-Location F:\Mod08
PSEdit .\HelloWorld.ps1
.\HelloWorldSigned.ps1
.\HelloWorld.ps1

Set-ExecutionPolicy RemoteSigned
.\HelloWorld.ps1

Set-ExecutionPolicy Unrestricted
.\HelloWorld.ps1

# Request a Code Siging certificate from AdatumCA
Set-Location -Path cert:\CurrentUser\My
Remove-Item -Path *
