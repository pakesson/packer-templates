#!/usr/bin/env bash

set -e # Break on errors
set -x # Print all commands as they execute

# Enable color for pacman
sed -i 's/#Color/Color/' /etc/pacman.conf

pacman -S --noconfirm git

pacman -S --noconfirm wget

pacman -S --noconfirm p7zip

pacman -S --noconfirm ripgrep

pacman -S --noconfirm bash-completion