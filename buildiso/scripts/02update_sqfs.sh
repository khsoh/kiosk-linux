#!/bin/bash

# This code chroot to the squashfs-root folder to update the contents of the 
# filesystem via apt
# You must be running this with sudo

# It is assumed that the squashfs_root folder is directly below the current directory

SCRIPTNAME=$(readlink -f "$0")
SCRIPTDIR=$(dirname "$SCRIPTNAME")

if [ ! "$EUID" = "0" ]; then
    echo "This script must be executed with sudo"
    exit 1
fi

if test $# -ne 0; then
    echo "Usage:"
    echo "  $0"
    exit 1
fi

if [ ! -d squashfs-root ]; then
    echo "squashfs-root is not present in this directory"
    echo "Filesystem may not have been uncompressed or you are running in the wrong directory"
    exit 1
fi

chroot squashfs-root /bin/bash -c "
# Skip the update and upgrade because it takes a long time
# apt update -y
# apt upgrade -y

apt install -y git xinput xdotool xbindkeys
apt autoremove
apt clean
"

