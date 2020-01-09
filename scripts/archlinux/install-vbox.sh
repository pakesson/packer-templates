#!/usr/bin/env bash

set -e # Break on errors
set -x # Print all commands as they execute

# VirtualBox Guest Additions
# https://wiki.archlinux.org/index.php/VirtualBox
pacman -S --noconfirm linux-headers virtualbox-guest-utils virtualbox-guest-modules-arch nfs-utils
echo -e 'vboxguest\nvboxsf\nvboxvideo' > /etc/modules-load.d/virtualbox.conf

systemctl enable vboxservice.service

# Add groups for VirtualBox folder sharing
usermod --append --groups vboxsf arch