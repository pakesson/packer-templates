Write-Host "Adding certificates"

$qxldodCert = (Get-AuthenticodeSignature "E:\qxldod\w10\amd64\qxldod.cat").SignerCertificate
[System.IO.File]::WriteAllBytes("$env:temp\redhat_qxldod.cer", $qxldodCert.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Cert))
certutil.exe -f -addstore "TrustedPublisher" "$env:temp\redhat_qxldod.cer"
Remove-Item -Path "$env:temp\redhat_qxldod.cer"

$blnCert = (Get-AuthenticodeSignature "E:\Balloon\w10\amd64\blnsvr.exe").SignerCertificate
[System.IO.File]::WriteAllBytes("$env:temp\redhat_balloon.cer", $blnCert.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Cert))
certutil.exe -f -addstore "TrustedPublisher" "$env:temp\redhat_balloon.cer"
Remove-Item -Path "$env:temp\redhat_balloon.cer"

$driverList = driverquery /V

if ($driverList -notmatch "netkvm") {
    Write-Host "Installing NetKVM"
    pnputil -i -a "E:\NetKVM\w10\amd64\*.inf"
}

if ($driverList -notmatch "viostor") {
    Write-Host "Installing viostor"
    pnputil -i -a "E:\viostor\w10\amd64\*.inf"
}

if ($driverList -notmatch "qxldod") {
    Write-Host "Installing qxldod"
    pnputil -i -a "E:\qxldod\w10\amd64\*.inf"
}

if ($driverList -notmatch "balloon") {
    Write-Host "Installing Balloon"
    pnputil -i -a "E:\Balloon\w10\amd64\*.inf"
}

if ($driverList -notmatch "viorng") {
    Write-Host "Installing viorng"
    pnputil -i -a "E:\viorng\w10\amd64\*.inf"
}

if ($driverList -notmatch "vioserial") {
    Write-Host "Installing vioserial"
    pnputil -i -a "E:\vioserial\w10\amd64\*.inf"
}

if ($driverList -notmatch "vioinput") {
    Write-Host "Installing vioinput"
    pnputil -i -a "E:\vioinput\w10\amd64\*.inf"
}

if ($driverList -notmatch "pvpanic") {
    Write-Host "Installing pvpanic"
    pnputil -i -a "E:\pvpanic\w10\amd64\*.inf"
}

Write-Host "Installing Qemu Guest Agent"
Start-Process "msiexec" -ArgumentList "/i E:\guest-agent\qemu-ga-x64.msi /quiet /qn /norestart" -Wait

Write-Host "Virtio drivers installed"