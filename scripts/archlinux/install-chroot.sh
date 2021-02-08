#!/usr/bin/env bash

set -e # Break on errors
set -x # Print all commands as they execute

echo "${LOCAL_HOSTNAME}" > /etc/hostname

# Locale etc.
ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
echo "KEYMAP=${KEYMAP}" > /etc/vconsole.conf
sed -i "s/#${LOCALE}/${LOCALE}/" /etc/locale.gen
locale-gen
echo "LANG=${LOCALE}" > /etc/locale.conf

# Recreate the initramfs image
mkinitcpio -p linux

# Users
usermod --password ${PASSWORD} root # Set root password
useradd --password ${PASSWORD} --comment 'Arch Linux User' --create-home --user-group arch
echo 'arch ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/10_archuser
chmod 0440 /etc/sudoers.d/10_archuser

# Networking
#mkdir -p /etc/systemd/network
#ln -sf /dev/null /etc/systemd/network/99-default.link
ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules

systemctl enable sshd
systemctl enable dhcpcd@eth0

# Install and configure bootloader
grub-install "$DISK"
sed -i -e 's/^GRUB_TIMEOUT=.*$/GRUB_TIMEOUT=1/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
