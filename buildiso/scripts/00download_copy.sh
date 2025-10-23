#!/bin/bash

# This code performs the following:
# - Download ISO image from URL (if given a web url)
# - Mount the ISO image
# - Copies the contents of ISO to a directory
# - Unsquashes the filesystem in live/filesystem.squashfs 

SCRIPTNAME=$(readlink -f "$0")
SCRIPTDIR=$(dirname "$SCRIPTNAME")

if test $# -ne 2; then
    echo "Usage:"
    echo "  $0 <URL of ISO image or filename> <new folder to copy ISO contents>"
    exit 1
fi

if [ -e $2 ]; then
    echo "ERROR: Directory $2 already exist"
    exit 1
fi

# For wattOS-R13 ISO
#   you may use: https://extantpc.com/iso/wattOS-R13.iso

FN=$(basename $1)
if [[ "$1" =~ ^(https?|ftp):// ]]; then
    wget "$1"
elif [[ "$1" =~ ^file:// ]]; then
    furl="$1"
    FN="${furl#file://}"
fi

echo Mounting ISO image to /media
sudo mount -o loop "$FN" /media

echo Copying the ISO contents to $2
sudo cp -a /media $2

sudo umount /media

echo Unsquashing filesystem
sudo unsquashfs $2/live/filesystem.squashfs

