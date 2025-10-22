#!/bin/bash

# This code update the contents of the ISO folder and the
# uncompressed folder that contained the folder of the compressed filesystem 

# It is assumed that the squashfs_root folder is directly below the current directory

SCRIPTNAME=$(readlink -f "$0")
SCRIPTDIR=$(dirname "$SCRIPTNAME")


if test $# -ne 1; then
    echo "Usage:"
    echo "  $0 <ISO contents folder>"
    exit 1
fi

if [ ! -d squashfs-root ]; then
    echo "squashfs-root is not present in this directory"
    echo "Filesystem may not have been uncompressed or you are running in the wrong directory"
    exit 1
fi

ISOPATH=$(realpath $1)
if [ ! -e $ISOPATH/live/filesystem.squashfs ]; then
    echo "Cannot find $ISOPATH/live/filesystem.squashfs"
    exit 1
fi


sudo rsync -rlp --exclude 'README.md' $SCRIPTDIR/../modiso/  squashfs-root/

sudo rsync -rlp --exclude 'README.md' $SCRIPTDIR/../../wattos/iso/  $ISOPATH/


