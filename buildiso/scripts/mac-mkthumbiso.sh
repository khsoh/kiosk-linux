#!/bin/sh

if diskutil list $2 | head -1 | grep external > /dev/null ; then
    sudo dd if=$1 of=$2 bs=4M status=progress
else
    echo $2 is not an external device - will not run command
fi

