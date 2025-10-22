#!/bin/bash

SCRIPTNAME=$(readlink -f "$0")
SCRIPTDIR=$(dirname "$SCRIPTNAME")

if cat /proc/cmdline | grep "/live" ; then
	# Set power button to power off and then skip rest of code if running live
	xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/power-button-action -s 4
	exit
fi

if [ ! -e "$SCRIPTDIR/firstrun" ]; then
	# Set power button to power off
	xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/power-button-action -s 4

    # Initialize firstrun file
    cp /dev/null "$SCRIPTDIR/firstrun"
fi

echo Checking for Internet connection...

if ! /usr/bin/nm-online --timeout=20 || [ ! -d ~/kiosk ]; then
    lxterminal --command "$SCRIPTDIR/nextrun.sh"
fi
