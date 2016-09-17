#!/bin/bash

set -e
set -x

#######
# Misc
#######
sudo apt-get -y install git

######
# GUI
######
# PDF viewer
sudo apt-get -y install evince
# Archive management
sudo apt-get -y install xarchiver thunar-archive-plugin
# Web browser
sudo apt-get -y install firefox
# Text editor
sudo apt-get -y install gedit