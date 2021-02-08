#!/usr/bin/env bash

set -e # Break on errors
set -x # Print all commands as they execute

pacman -Sy --noconfirm

pacman -S --noconfirm xorg

pacman -S --noconfirm lightdm lightdm-gtk-greeter
systemctl enable lightdm.service
#pacman -S --noconfirm gdm
#systemctl enable gdm
#pacman -S --noconfirm lxdm-gtk3
#systemctl enable lxdm
pacman -S --noconfirm xorg-xinit

pacman -S --noconfirm i3-gaps
pacman -S --noconfirm i3blocks i3lock i3status 

pacman -S --noconfirm dmenu rofi # dmenu is in the default i3 config
pacman -S --noconfirm compton
pacman -S --noconfirm termite 
pacman -S --noconfirm ttf-dejavu ttf-droid terminus-font

#pacman -S --noconfirm polybar

pacman -S --noconfirm thunar
pacman -S --noconfirm lxappearance
pacman -S --noconfirm arc-gtk-theme arc-icon-theme
pacman -S --noconfirm elementary-icon-theme gtk-engine-murrine

# Sound
pacman -S --noconfirm pulseaudio pulseaudio-alsa
# If multilib is enabled
#pacman -S --noconfirm lib32-libpulse lib32-alsa-plugins

pacman -S --noconfirm xdg-utils