#!/bin/bash

set -e # Break on errors
set -x # Print all commands as they execute

sudo apt-get -y install dkms
sudo apt-get -y install make
sudo apt-get -y install build-essential

sudo mount -o loop,ro ~/VBoxGuestAdditions.iso /mnt/
sudo /mnt/VBoxLinuxAdditions.run || :
sudo umount /mnt/
rm -f ~/VBoxGuestAdditions.iso

# Note: This adds the user to the 'vboxsf' group for VirtualBox shared folders
sudo usermod -G vboxsf -a xubuntu
