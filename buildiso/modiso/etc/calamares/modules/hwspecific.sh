#!/bin/bash

if [[ -d /tmp/hwspecific ]]; then
    rsync -rlp --exclude "README.md" /tmp/hwspecific/ /etc/skel
fi
