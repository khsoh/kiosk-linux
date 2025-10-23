#!/bin/bash

# TO BE RUN IN LINUX SYSTEM
# Create a new squashfs filesystem, replace it in the ISO folder
# and recompute the sha256sum file
#
SCRIPTNAME=$(readlink -f "$0")
SCRIPTDIR=$(dirname "$SCRIPTNAME")

if [ ! "$EUID" = "0" ]; then
    echo "This script must be executed with sudo"
    exit 1
fi

if test $# -ne 2; then
    echo "Usage:"
    echo "  $0 <ISO contents folder> <ISO image filename>"
    exit 1
fi

if [ ! -d squashfs-root ]; then
    echo "squashfs-root is not present in this directory"
    echo "Filesystem may not have been uncompressed or you are running in the wrong directory"
    exit 1
fi

ISOPATH=$(realpath $1)
if [ ! -d "$ISOPATH" ]; then
    echo "ISO folder not detected in $ISOPATH"
    exit 1
fi
if [ ! -d "$ISOPATH/live" ]; then
    echo "ISO live folder not detected in $ISOPATH/live"
    exit 1
fi

# Remove ISO file
if [ -e $2 ]; then
    rm -f $2
fi

mksquashfs squashfs-root filesystem.squashfs -comp xz -b 1M

mv -f filesystem.squashfs $ISOPATH/live


pushd $ISOPATH
grep -Ff <(awk '{print $2}' ./sha256sum.txt) <(find . -type f -print0 | sort -z | xargs -r0 sha256sum) >shx.txt
mv -f shx.txt sha256sum.txt
popd

FULLDATE=$(env TZ="Asia/Singapore" date +"%Y%m%d-%H%M%S%2N")
IFS='-' read -r STRDATE STRTIME <<< "$FULLDATE"

xorriso -as mkisofs -R -r -J -joliet-long -l -cache-inodes -iso-level 3 -A "Debian Live" -publisher "ZBAV Tech Lead" -V "ZBAV_KIOSK" --modification-date=$STRDATE$STRTIME -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e boot/grub/efi.img -no-emul-boot -isohybrid-gpt-basdat -isohybrid-apm-hfsplus -o $2 $ISOPATH

