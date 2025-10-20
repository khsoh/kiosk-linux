#!/bin/bash

# Skip if running live
if cat /proc/cmdline | grep "/live" ; then
    ROTATE=$(cat /proc/cmdline|/bin/sed -r -n -e 's/.*\s(fbcon=rotate:.).*/\1/p')
    if [ ! -z "$ROTATE" ]; then
        sudo echo "GRUB_CMDLINE_LINUX_DEFAULT=\"\$GRUB_CMDLINE_LINUX_DEFAULT $ROTATE\"" > /etc/default/grub.d/rotate.cfg
    fi
	exit
fi

if [ ! -e "~/firstrun" ]; then
	# Set power button to power off
	xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/power-button-action -s 4

    # Initialize firstrun file
    cp /dev/null ~/firstrun
fi

echo Checking for Internet connection...

if ! /usr/bin/nm-online --timeout=20 ; then

	echo WiFi APs:
	nmcli -f SSID device wifi list | tail -n +2 | grep -v "^\-\-" | sort | uniq

	echo " "

	read -p "WiFi AP to connect to: " wifiap

	nmcli device wifi connect $wifiap --ask
fi

if [ ! -d ~/kiosk ]; then
	git clone https://github.com/khsoh/kiosk-linux.git ~/kiosk
	pushd ~/kiosk
	source ./bootstrap.sh
	source ./setup_kiosk.sh
	popd
fi
