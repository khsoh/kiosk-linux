#!/bin/bash

# This code performs the following:
# - Download ISO image from URL
# - Mount the ISO image
# - Copies the contents of ISO to a directory
# - Unsquashes the filesystem in live/filesystem.squashfs 

SCRIPTNAME=$(readlink -f "$0")
SCRIPTDIR=$(dirname "$SCRIPTNAME")

if test $# -ne 2; then
    echo "Usage:"
    echo "  $0 <URL of ISO image> <new folder to copy ISO contents>"
    exit 1
fi

if [ -e $2 ]; then
    echo "ERROR: Directory $2 already exist"
    exit 1
fi

# For wattOS-R13 ISO
#   you may use: https://extantpc.com/iso/wattOS-R13.iso

wget $1

echo Mounting ISO image to /media
sudo mount -o loop $(basename $1) /media

echo Copying the ISO contents to $2
sudo cp -a /media $2

sudo umount /media

echo Unsquashing filesystem
sudo unsquashfs $2/live/filesystem.squashfs

