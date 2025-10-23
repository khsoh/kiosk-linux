#!/bin/bash

SCRIPTNAME=$(readlink -f "$0")
SCRIPTDIR=$(dirname "$SCRIPTNAME")

if [ -e /etc/default/hwsetup ]; then
    ## Hardware setup already done - just exit
    exit
fi

shopt -s nullglob

pushd /etc/hwspecific
dirs=(*/)
popd

shopt -u nullglob

HWSEL=""

while [ "$HWSEL" == "" ]; do
    echo "Select your hardware by typing the number:"
    for index in "${!dirs[@]}"; do
        echo "[${index}] - ${dirs[$index]}"
    done
    read -s -p "Type number then press <ENTER>: " HWIDX
    if [[ $HWIDX =~ ^[0-9]+$ && "$HWIDX" -ge "0" && "$HWIDX" -lt "${#dirs[@]}" ]]; then
        HWSEL=${dirs[$HWIDX]}
    else
        echo "Bad input.  Try again"
        echo " "
        echo " "
    fi
done

# Save this to hwsetup file
sudo echo $HWSEL > /etc/default/hwsetup

rsync -rlp /etc/hwspecific/$HWSEL/etc/skel/ --exclude "README.md" ~

## We do not need the following because .xbindkeysrc is non-empty always
##killall -HUP xbindkeys > /dev/null 2>&1
##pgrep xbindkeys >/dev/null || xbindkeys -p

