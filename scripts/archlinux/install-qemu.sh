#!/usr/bin/env bash

set -e # Break on errors
set -x # Print all commands as they execute

pacman -S --noconfirm xf86-video-qxl

pacman -S --noconfirm qemu-guest-agent
systemctl enable qemu-guest-agent.service

pacman -S --noconfirm spice-vdagent