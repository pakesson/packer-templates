#!/usr/bin/env bash

set -e # Break on errors
set -x # Print all commands as they execute

pacman -S --noconfirm xf86-video-qxl

pacman -S --noconfirm qemu-guest-agent
systemctl enable qemu-guest-agent.service

pacman -S --noconfirm spice-vdagent
#systemctl enable spice-vdagentd.service
#echo "[Unit]\nAfter=dbus.service" > /etc/systemd/system/spice-vdagentd.service.d/override.conf
