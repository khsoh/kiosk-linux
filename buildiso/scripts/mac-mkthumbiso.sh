#!/bin/bash

if test $# -ne 2; then
    echo "Usage:"
    echo "  $0 <ISO image file> <device disk of thumbdrive>"
    echo "Example:"
    echo "  $0 zb.iso /dev/disk4"
    exit 1
fi

if [[ "$(diskutil list external $2)" != "" ]]; then
    BDISK="${2/rdisk/disk}"
    RDISK="${BDISK/disk/rdisk}"
    # Unmount the buffered disk first
    if df -h /dev/disk4 >/dev/null 2>&1; then
        diskutil unmountDisk $BDISK
    fi

    # Write to raw disk
    sudo dd if=$1 of=$RDISK bs=4M status=progress

    diskutil eject $BDISK

else
    echo $2 is not an external device - will not run command
fi

