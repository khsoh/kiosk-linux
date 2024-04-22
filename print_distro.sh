#!/usr/bin/env bash

## Echo the distro subdirectory

if [[ -d /etc/calamares/branding/wattOS ]]; then
    echo "wattos"
else
    echo "Unknown distribution.  Executing lsb_release -a"
    lsb_release -a
    echo "The kiosk project supports the following distributions:"
    echo "  Xubuntu"
    echo "  wattOS"
    return 1
fi

return 0
