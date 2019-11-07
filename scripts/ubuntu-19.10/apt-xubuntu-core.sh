#!/bin/bash

set -e # Break on errors
set -x # Print all commands as they execute

sudo apt-get -y -qq install xubuntu-core^

# Needed for application launchers to work.
# Gets rid of the
#   /usr/lib/x86_64-linux-gnu/xfce4/exo-1/exo-helper-1: not found
# error.
#sudo apt-get -y install libexo-1-0
