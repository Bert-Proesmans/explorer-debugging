$progressPreference = 'silentlyContinue'

# FUN FACT; WINDBG INSTALLATION DOESN'T WORK THROUGH WINGET
# I presume because winget calls into the Windows Store API, which isn't available within the Windows Containers

# Write-Information "Downloading WinGet and its dependencies..."
# Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile 'Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'
# Invoke-WebRequest -Uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile 'Microsoft.VCLibs.x64.14.00.Desktop.appx'
# Invoke-WebRequest -Uri https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.7.3/Microsoft.UI.Xaml.2.7.x64.appx -OutFile 'Microsoft.UI.Xaml.2.7.x64.appx'
# Add-AppxPackage 'Microsoft.VCLibs.x64.14.00.Desktop.appx'
# Add-AppxPackage 'Microsoft.UI.Xaml.2.7.x64.appx'
# Add-AppxPackage 'Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'

# Write-Information "Ensuring Winget is registered on system"
# Add-AppxPackage -RegisterByFamilyName -MainPackage 'Microsoft.DesktopAppInstaller_8wekyb3d8bbwe'

function refresh-path {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") +
                ";" +
                [System.Environment]::GetEnvironmentVariable("Path","User")
}

# Write-Information "Installing WinDBG"
# refresh-path
# winget.exe install --exact --id 'Microsoft.WinDbg' --silent --disable-interactivity --accept-package-agreements --accept-source-agreements

Write-Information "Installing WinDBG"
# Make sure to download the WinDBG bundle from https://windbg.download.prss.microsoft.com/dbazure/prod/1-2306-12001-0/windbg.msixbundle
# REF; https://github.com/microsoft/winget-pkgs/blob/e63cf7af93490e1b3d21f7eea3d7f3df35efe357/manifests/m/Microsoft/WinDbg/1.2306.12001.0/Microsoft.WinDbg.installer.yaml#L21
Add-AppxPackage '.\packages\windbg.msixbundle'

Write-Information "Launching WinDBG"
refresh-path
windbg.exe -WX -Q -QS -QSY -QY -pd -g -o -pn explorer.exe -y "C:\symbolcache"