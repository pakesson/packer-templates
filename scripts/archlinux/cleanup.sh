#!/bin/bash

# Do not break on errors, since dd will fill the disk - resulting in an error

set -x # Print all commands as they execute

yes | pacman -Scc

#zerofile=$(/usr/bin/mktemp /zerofile.XXXXX)
#dd if=/dev/zero of="$zerofile" bs=1M
#rm -f "$zerofile"
#sync