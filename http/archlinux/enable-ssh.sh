#!/usr/bin/env bash

PASSWORD=$(/usr/bin/openssl passwd -crypt 'password')

/usr/bin/useradd --password ${PASSWORD} --comment 'Arch Linux User' --create-home --user-group arch
echo 'Defaults env_keep += "SSH_AUTH_SOCK"' > /etc/sudoers.d/10_archuser
echo 'arch ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/10_archuser
/usr/bin/chmod 0440 /etc/sudoers.d/10_archuser
/usr/bin/systemctl start sshd.service