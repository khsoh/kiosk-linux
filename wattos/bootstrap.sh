#!/usr/bin/env bash

SCRIPTNAME=$(readlink -f ${BASH_SOURCE[0]})
pushd "$(dirname $SCRIPTNAME)" > /dev/null

git pull --recurse-submodules origin main

sudo apt update -y
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo apt autoremove

sudo apt install -y stow

# Sets up the symlinks with stow
stow -Rt ~ ../LINUX 

popd >/dev/null
