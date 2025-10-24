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

# Number of items ${#dirs[@]}
while [[ "$HWSEL" == "" ]]; do
    echo "Select your hardware by typing the number:"
    for index in "${!dirs[@]}"; do
        echo "[${index}] - ${dirs[$index]}"
    done
    if [[ ${#dirs[@]} -le 9 ]]; then
        read -s -n 1 -p "Type number: " HWIDX
    else
        read -s -p "Type number then press <ENTER>: " HWIDX
    fi
    if [[ $HWIDX =~ ^[0-9]+$ && "$HWIDX" -ge "0" && "$HWIDX" -lt "${#dirs[@]}" ]]; then
        HWSEL=${dirs[$HWIDX]}
    else
        echo "Bad input.  Try again"
        echo " "
        echo " "
    fi
done


HWSEL="${HWSEL%/}"

# Save this to hwsetup file
sudo bash -c "echo \"$HWSEL\" > /etc/default/hwsetup"

rsync -rlp /etc/hwspecific/$HWSEL/etc/skel/ --exclude "README.md" ~

## Signal to xbindkeys to re-read the configuration file
killall -HUP xbindkeys > /dev/null 2>&1

## Restart xbindkeys if it is absent
pgrep xbindkeys >/dev/null || xbindkeys

