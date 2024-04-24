#!/usr/bin/env bash

## Echo the distro subdirectory

if [[ -d /etc/calamares/branding/wattOS ]]; then
    echo "wattos"
elif [[ -d /etc/calamares/branding/peppermint ]]; then
    echo "peppermint"
elif [[ "$(lsb_release -s -i)" = "Ubuntu" ]]; then
    echo "ubuntu"
else
    echo "Unknown distribution.  Executing lsb_release -a"
    lsb_release -a
    echo "The kiosk project supports the following distributions:"
    echo "  Ubuntu/Xubuntu/Lubuntu"
    echo "  wattOS"
    return 1
fi

return 0
