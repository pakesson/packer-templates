# Disable hibernation
Set-ItemProperty                                                               `
    -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Power'                       `
    -Name HiberFileSizePercent                                                 `
    -Value 0

Set-ItemProperty                                                               `
    -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Power'                       `
    -name HibernateEnabled                                                     `
    -Value 0

# Disable consumer experience
New-Item -Path 'HKLM:\Software\Policies\Microsoft\Windows' -Name CloudContent -ErrorAction SilentlyContinue
Set-ItemProperty                                                               `
    -Path 'HKLM:\Software\Policies\Microsoft\Windows\CloudContent'             `
    -Name DisableWindowsConsumerFeatures                                       `
    -Value 1                                                                   `
    -Force

# Re-enable LUA/UAC
Set-ItemProperty                                                               `
    -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\policies\system'    `
    -Name EnableLUA                                                            `
    -Value 1