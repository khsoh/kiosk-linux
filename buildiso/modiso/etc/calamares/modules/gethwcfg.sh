#!/bin/bash

TARGET="$1"

# This script is only run during calamares setup
if [[ ! -d "$TARGET" ]]; then
    exit 1
fi

# Assume others selection
HWSEL="others"
if [[ -f /etc/default/hwsetup ]]; then
    HWSEL=$(cat /etc/default/hwsetup)
    if [[ ! -d "/etc/hwspecific/$HWSEL" ]]; then
        HWSEL="others"
    fi
fi

rsync -rlp --exclude "README.md" /etc/hwspecific/$HWSEL/ $TARGET

