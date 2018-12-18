# Arch Linux

Only for VirtualBox at the moment.

# Windows 10 Enterprise

Only for KVM/QEMU at the moment.

## Prerequisites

Download the ISO files for Windows 10 Enterprise and VirtIO (can be found at
https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-virtio/virtio-win.iso)

Get the SHA256 hash for the Windows ISO file.

Copy the file `http/windows-10-enterprise/Autounattend.xml.example` to
`http/windows-10-enterprise/Autounattend.xml` and edit the license key (and
whatever else you want to change).

## Building
```
packer build -var "iso_url=path/to/en_windows_10_business_edition_version_1809_updated_sept_2018_x64_dvd_f0b7dc68.iso" -var "iso_checksum=foobar" -var "virtio_win_iso=path/to/virtio-win.iso" windows-10-enterprise.json
```

# Xubuntu

Templates for both VirtualBox and KVM/QEMU, for the latest version of Xubuntu.

## Building

To build for only one hypervisor, use
```
packer build -only=qemu xubuntu-18.10-core.json
```