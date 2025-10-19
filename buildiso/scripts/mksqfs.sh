#!/bin/bash

# TO BE RUN IN LINUX SYSTEM
# Purpose: Recompute the SHA256 for live/filesystem.squashfs in sha256sum.txt file 
#          of the ISO image
sudo mksquashfs $1 filesystem.squashfs -comp xz -b 1M
sudo mv -f filesystem.squashfs $2/live

pushd $2
FN="./live/filesystem.squashfs"
NEW_HASH=$(sudo sha256sum $FN | awk '{print $1}')

# Replace the checksum for $FN in sha256sum.txt
sudo sed -i "s|^[a-f0-9]\{64\}  *$FN|$NEW_HASH  $FN|" "sha256sum.txt"
popd
