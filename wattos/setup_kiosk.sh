#!/usr/bin/env bash

SCRIPTNAME=$(readlink -f ${BASH_SOURCE[0]})
pushd "$(dirname $SCRIPTNAME)" > /dev/null

DEFAULT_KIOSKURL=https://studio.youtube.com/channel/@ZionBishan/livestreaming/manage
read -p "Kiosk URL (press ENTER for default): " KIOSKURL

if [ -z "$KIOSKURL" ]; then
    KIOSKURL="$DEFAULT_KIOSKURL"
fi

cat << __kiosk_desktop > $XDG_CONFIG_HOME/autostart/kiosk.desktop
[Desktop Entry]
Type=Application
Name=Kiosk
Icon=/usr/share/firefox-esr/browser/chrome/icons/default/default128.png
Exec=/bin/sh -c "/usr/bin/nm-online --quiet --timeout=60 && /usr/bin/firefox --kiosk $KIOSKURL"
__kiosk_desktop
chmod +x $XDG_CONFIG_HOME/autostart/kiosk.desktop

# Make a desktop shortcut for the script
if [[ ! -d "$HOME/Desktop" ]]; then
    mkdir "$HOME/Desktop"
fi
ln -s $XDG_CONFIG_HOME/autostart/kiosk.desktop "$HOME/Desktop/kiosk.desktop"

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
/usr/bin/firefox --kiosk $KIOSKURL &


popd > /dev/null

