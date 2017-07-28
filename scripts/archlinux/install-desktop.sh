#!/usr/bin/env bash

set -e # Break on errors
set -x # Print all commands as they execute

sudo pacman -Syyu --noconfirm

sudo pacman -S --noconfirm xorg

sudo pacman -S --noconfirm lightdm lightdm-gtk-greeter
sudo systemctl enable lightdm.service

# Dependencies for cower and pacaur
sudo pacman -S --noconfirm git
sudo pacman -S --noconfirm expac yajl

echo $PATH
PATH=$PATH:/usr/bin/core_perl

mkdir /tmp/aur-build
cd /tmp/aur-build

gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53
curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cower
makepkg -i PKGBUILD --noconfirm

curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=pacaur
makepkg -i PKGBUILD --noconfirm

cd ~
rm -rf /tmp/aur-build

# Enable color for pacman
sudo sed -i 's/#Color/Color/' /etc/pacman.conf

pacaur -S --noconfirm i3-gaps
sudo pacman -S --noconfirm dmenu rofi # dmenu is in the default i3 config
sudo pacman -S --noconfirm compton
sudo pacman -S --noconfirm termite 
sudo pacman -S --noconfirm ttf-dejavu ttf-droid terminus-font
pacaur -S --noconfirm siji-git ttf-unifont

pacaur -S --noconfirm polybar-git # The regular 'polybar' package currently does not build
                                  # Also pulls in clang, cmake, jsoncpp and libuv

sudo pacman -S --noconfirm thunar
sudo pacman -S --noconfirm lxappearance
pacaur -S --noconfirm arc-gtk-theme arc-icon-theme
sudo pacman -S --noconfirm elementary-icon-theme gtk-engine-murrine