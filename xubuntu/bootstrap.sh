#!/usr/bin/env bash

SCRIPTNAME=$(readlink -f ${BASH_SOURCE[0]})
pushd "$(dirname $SCRIPTNAME)" > /dev/null

sudo apt install -y vim
git pull --recurse-submodules origin main

sudo snap refresh

sudo apt install -y stow

# Sets up the symlinks with stow
stow -Rt ~ ../LINUX

popd >/dev/null
