#!/bin/bash

set -e # Break on errors
set -x # Print all commands as they execute

sudo apt-get -y install dkms
sudo apt-get -y install make
sudo apt-get -y install build-essential

# Uncomment this if you want to install Guest Additions with support for X
#sudo apt-get -y install xserver-xorg

sudo mount -o loop,ro ~/VBoxGuestAdditions.iso /mnt/
sudo /mnt/VBoxLinuxAdditions.run || :
sudo umount /mnt/
rm -f ~/VBoxGuestAdditions.iso

VBOX_VERSION=$(cat ~/.vbox_version)
if [ "$VBOX_VERSION" == '4.3.10' ]; then
  # https://www.virtualbox.org/ticket/12879
  sudo ln -s "/opt/VBoxGuestAdditions-$VBOX_VERSION/lib/VBoxGuestAdditions" /usr/lib/VBoxGuestAdditions
fi

# Note: This adds the user to the 'vboxsf' group for VirtualBox shared folders
sudo usermod -G vboxsf -a xubuntu