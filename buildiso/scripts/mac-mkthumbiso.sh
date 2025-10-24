#!/bin/bash

if diskutil list $2 | head -1 | grep external > /dev/null ; then
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

