#!/usr/bin/env bash

SCRIPTNAME=$(readlink -f ${BASH_SOURCE[0]})
pushd "$(dirname $SCRIPTNAME)" > /dev/null

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

if [[ ! -d "$XDG_CONFIG_HOME/autostart" ]]; then
    mkdir "$XDG_CONFIG_HOME/autostart"
fi
read -p "Kiosk URL: " KIOSKURL

cat << __kiosk_desktop > $XDG_CONFIG_HOME/autostart/kiosk.desktop
[Desktop Entry]
Type=Application
Name=Kiosk
Icon=/snap/firefox/current/default256.png
Exec=/bin/sh -c "/usr/bin/nm-online --quiet --timeout=60 && /snap/bin/firefox --kiosk $KIOSKURL"
__kiosk_desktop
chmod +x $XDG_CONFIG_HOME/autostart/kiosk.desktop

# Make a desktop shortcut for the script
if [[ ! -d "$HOME/Desktop" ]]; then
    mkdir "$HOME/Desktop"
fi
ln -s $XDG_CONFIG_HOME/autostart/kiosk.desktop "$HOME/Desktop/kiosk.desktop"

# Check that ibus is present in $HOME/.config
if [[ ! -d "$HOME/.config/ibus" ]]; then
    mkdir "$HOME/.config/ibus"
fi

echo ""
echo ""
echo "====================================="
echo "kiosk.desktop has been created in the"
echo "    '$XDG_CONFIG_HOME/autostart' directory to run the kiosk at startup"
echo ""
echo "$HOME/Desktop/kiosk.desktop desktop shortcut has been created for this script"
echo "====================================="
echo ""
echo "Will be starting firefox automatically first to perform account login to kiosk"

sleep 3
/snap/bin/firefox --kiosk $KIOSKURL &

popd > /dev/null

