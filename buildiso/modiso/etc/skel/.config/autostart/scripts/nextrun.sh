#!/bin/bash

SCRIPTNAME=$(readlink -f "$0")
SCRIPTDIR=$(dirname "$SCRIPTNAME")

if ! /usr/bin/nm-online --timeout=1 ; then
    echo ==== NO INTERNET CONNECTION ====
    echo Setting up WiFi
    echo ""

	echo WiFi APs:
	nmcli -f SSID device wifi list | tail -n +2 | grep -v "^\-\-" | sort | uniq

	echo " "

	read -p "WiFi AP to connect to: " wifiap

	nmcli device wifi connect $wifiap --ask
fi

if [ ! -d ~/kiosk ]; then
    echo ==== Kiosk not yet setup ====
    echo Setting up kiosk by cloning from git repo
    echo This will take a while
    echo ...

    read -s -n 1 -p "Press any key to continue..." XX

    echo ""
    echo ""
    echo ""

	git clone https://github.com/khsoh/kiosk-linux.git ~/kiosk
	pushd ~/kiosk
	source ./bootstrap.sh
	source ./setup_kiosk.sh
	popd

    read -s -n 1 -p "Press any key to reboot..." YY
    sudo shutdown -r now
fi
