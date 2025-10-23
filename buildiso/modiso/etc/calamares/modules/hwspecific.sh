#!/bin/bash

if [[ -d /run/calamares/hwspecific ]]; then
    rsync -rlp --exclude "README.md" /run/calamares/hwspecific/ /etc/skel
fi
