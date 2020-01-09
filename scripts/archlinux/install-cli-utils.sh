#!/usr/bin/env bash

set -e # Break on errors
set -x # Print all commands as they execute

# Enable color for pacman
sed -i 's/#Color/Color/' /etc/pacman.conf

pacman -S --noconfirm git

pacman -S --noconfirm wget

pacman -S --noconfirm p7zip

pacman -S --noconfirm ranger
# Optional dependencies for ranger:
pacman -S --noconfirm atool     # for previews of archives
pacman -S --noconfirm highlight # for syntax highlighting of code
pacman -S --noconfirm mediainfo # for viewing information about media files
pacman -S --noconfirm odt2txt   # for OpenDocument texts
pacman -S --noconfirm poppler   # for pdf previews

pacman -S --noconfirm ripgrep

pacman -S --noconfirm bat   # cat replacement
pacman -S --noconfirm exa   # ls replacement
pacman -S --noconfirm fd    # find replacement
pacman -S --noconfirm hexyl # hex viewer

pacman -S --noconfirm bash-completion