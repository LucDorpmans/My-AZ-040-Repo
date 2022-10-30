# GitHub Desktop Silent Install (EXE)
# Download the GitHubDesktopSetup-x64.exe 
Invoke-WebRequest -uri "https://central.github.com/deployments/desktop/desktop/latest/win32" -OutFile $ENV:temp\GitHubDesktopSetup-x64.exe

# Install Silently: 
& $ENV:temp\GitHubDesktopSetup-x64.exe -s
