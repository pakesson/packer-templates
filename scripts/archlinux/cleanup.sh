#!/bin/bash

# Do not break on errors, since dd will fill the disk - resulting in an error

set -x # Print all commands as they execute

/usr/bin/yes | /usr/bin/pacman -Scc
/usr/bin/pacman-optimize

zerofile=$(/usr/bin/mktemp /zerofile.XXXXX)
/usr/bin/dd if=/dev/zero of="$zerofile" bs=1M
/usr/bin/rm -f "$zerofile"
/usr/bin/sync