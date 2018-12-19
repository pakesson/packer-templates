Invoke-WebRequest -Uri "https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-latest.exe" -OutFile "$env:temp\spice-guest-tools-latest.exe"
Start-Process "$env:temp\spice-guest-tools-latest.exe" -ArgumentList "/S" -Wait
Remove-Item -Path "$env:temp\spice-guest-tools-latest.exe"

Invoke-WebRequest -Uri "https://www.spice-space.org/download/windows/spice-webdavd/spice-webdavd-x64-latest.msi" -OutFile "$env:temp\spice-webdavd-x64-latest.msi"
msiexec /i "$env:temp\spice-webdavd-x64-latest.msi" /quiet /qn /norestart
Remove-Item -Path "$env:temp\spice-webdavd-x64-latest.msi"