variable "country" {
  type    = string
  default = "SE"
}

variable "cpus" {
  type    = string
  default = "2"
}

variable "disk_size" {
  type    = string
  default = "80000"
}

variable "iso_checksum_type" {
  type    = string
  default = "sha1"
}

variable "iso_checksum_url" {
  type    = string
  default = "https://mirrors.edge.kernel.org/archlinux/iso/2021.11.01/sha1sums.txt"
}

variable "iso_url" {
  type    = string
  default = "https://mirrors.edge.kernel.org/archlinux/iso/2021.11.01/archlinux-2021.11.01-x86_64.iso"
}

variable "memory" {
  type    = string
  default = "4096"
}

variable "vm_password" {
  type    = string
  default = "password"
}

variable "vm_username" {
  type    = string
  default = "arch"
}

variable "vram" {
  type    = string
  default = "32"
}

locals {
  vm_name = "archlinux-${formatdate("YYYYMMDD", timestamp())}"
}

source "qemu" "archlinux" {
  accelerator      = "kvm"
  boot_command     = [
    "<enter><wait10><wait10><wait10><wait5>",
    "/usr/bin/curl -O http://{{ .HTTPIP }}:{{ .HTTPPort }}/archlinux/enable-ssh.sh<enter><wait5>",
    "/usr/bin/bash ./enable-ssh.sh<enter>"
  ]
  boot_wait        = "5s"
  disk_interface   = "virtio"
  disk_size        = "${var.disk_size}"
  format           = "qcow2"
  http_directory   = "http"
  iso_checksum     = "file:${var.iso_checksum_url}"
  iso_url          = "${var.iso_url}"
  net_device       = "virtio-net"
  output_directory = "output-${local.vm_name}-qemu"
  qemuargs         = [
    ["-display", "gtk"],
    ["-m", "${var.memory}"],
    ["-smp", "${var.cpus}"]
  ]
  shutdown_command = "sudo systemctl poweroff"
  ssh_password     = "${var.vm_password}"
  ssh_port         = 22
  ssh_timeout      = "60m"
  ssh_username     = "${var.vm_username}"
  vm_name          = "${local.vm_name}-x86_64"
}

source "virtualbox-iso" "archlinux" {
  boot_command         = [
    "<enter><wait10><wait10>",
    "/usr/bin/curl -O http://{{ .HTTPIP }}:{{ .HTTPPort }}/archlinux/enable-ssh.sh<enter><wait5>",
    "/usr/bin/bash ./enable-ssh.sh<enter>"
  ]
  boot_wait            = "5s"
  disk_size            = "${var.disk_size}"
  format               = "ova"
  guest_additions_mode = "disable"
  guest_os_type        = "ArchLinux_64"
  hard_drive_interface = "sata"
  headless             = false
  http_directory       = "http"
  iso_checksum         = "file:${var.iso_checksum_url}"
  iso_url              = "${var.iso_url}"
  shutdown_command     = "sudo systemctl poweroff"
  ssh_password         = "password"
  ssh_timeout          = "60m"
  ssh_username         = "arch"
  vboxmanage           = [
    ["modifyvm", "{{ .Name }}", "--memory", "${var.memory}"],
    ["modifyvm", "{{ .Name }}", "--cpus", "${var.cpus}"],
    ["modifyvm", "{{ .Name }}", "--vram", "${var.vram}"]
  ]
  vm_name              = "${local.vm_name}-x86_64"
}

build {
  description = "Arch Linux"

  sources = ["source.qemu.archlinux", "source.virtualbox-iso.archlinux"]

  provisioner "file" {
    destination = "/tmp/install-chroot.sh"
    source      = "scripts/archlinux/install-chroot.sh"
  }

  provisioner "shell" {
    execute_command   = "{{ .Vars }} COUNTRY=${var.country} sudo -E -S bash '{{ .Path }}'"
    expect_disconnect = true
    scripts           = ["scripts/archlinux/install-init.sh"]
  }

  provisioner "shell" {
    execute_command = "{{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    only            = ["virtualbox-iso.archlinux"]
    pause_before    = "5s"
    script          = "scripts/archlinux/install-vbox.sh"
  }

  provisioner "shell" {
    execute_command = "{{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    only            = ["qemu.archlinux"]
    pause_before    = "5s"
    script          = "scripts/archlinux/install-qemu.sh"
  }

  provisioner "shell" {
    execute_command = "{{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    script          = "scripts/archlinux/install-cli-utils.sh"
  }

  provisioner "shell" {
    execute_command = "{{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    script          = "scripts/archlinux/install-desktop-xfce.sh"
  }

  provisioner "shell" {
    execute_command = "{{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    script          = "scripts/archlinux/cleanup.sh"
  }

}
