#!/usr/bin/env bash

set -e # Break on errors
set -x # Print all commands as they execute

if [ -e /dev/vda ]; then
  export DISK='/dev/vda'
elif [ -e /dev/sda ]; then
  export DISK='/dev/sda'
else
  echo "Could not identify target disk" >&2
  exit 1
fi

export LOCAL_HOSTNAME='arch.local'
export KEYMAP='se'
export LOCALE='en_US.UTF-8'
export PASSWORD=$(/usr/bin/openssl passwd -crypt 'password')
export TIMEZONE='Europe/Stockholm'
COUNTRY=${COUNTRY:-SE}

CONFIG_SCRIPT_SRC='/tmp/install-chroot.sh'
CONFIG_SCRIPT_DST='/usr/local/bin/arch-config.sh'
export SWAP_PARTITION="${DISK}1"
export ROOT_PARTITION="${DISK}2"
TARGET_DIR='/mnt'

MIRRORLIST="https://archlinux.org/mirrorlist/?country=SE&country=DK&protocol=https&ip_version=4&use_mirror_status=on"

echo "Setting local mirrors"
curl -fsS $MIRRORLIST | sed 's/^#Server/Server/' > /etc/pacman.d/mirrorlist
pacman -Sy --noconfirm
pacman -S reflector --noconfirm
reflector --verbose --country $COUNTRY --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

echo "Creating and configuring partitions on ${DISK}"
memory_size_in_kilobytes=$(free | awk '/^Mem:/ { print $2 }')
swap_size_in_kilobytes=$((memory_size_in_kilobytes * 2))
sfdisk "$DISK" <<EOF
label: dos
size=${swap_size_in_kilobytes}KiB, type=82
                                   type=83, bootable
EOF
mkswap "${SWAP_PARTITION}"
mkfs.ext4 -q -L root "${ROOT_PARTITION}"
mount "${ROOT_PARTITION}" /mnt

echo 'Bootstrapping the base installation'
pacstrap ${TARGET_DIR} base base-devel linux linux-firmware
arch-chroot ${TARGET_DIR} pacman -S --noconfirm openssh grub dhcpcd

echo 'Generating the filesystem table'
swapon "${SWAP_PARTITION}"
genfstab -p ${TARGET_DIR} >> "${TARGET_DIR}/etc/fstab"
swapoff "${SWAP_PARTITION}"

echo 'Entering chroot and configuring system'
install --mode=0755 ${CONFIG_SCRIPT_SRC} "${TARGET_DIR}${CONFIG_SCRIPT_DST}"
arch-chroot ${TARGET_DIR} ${CONFIG_SCRIPT_DST}
rm "${TARGET_DIR}${CONFIG_SCRIPT_DST}"

echo 'Installation complete!'
sleep 3
umount ${TARGET_DIR}
systemctl reboot
