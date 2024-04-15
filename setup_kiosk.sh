#!/usr/bin/env bash

SCRIPTNAME=$(readlink -f ${BASH_SOURCE[0]})
pushd "$(dirname $SCRIPTNAME)" > /dev/null

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

if [[ ! -d "$XDG_CONFIG_HOME/autostart" ]]; then
    mkdir "$XDG_CONFIG_HOME/autostart"
fi
read -p "Kiosk URL: " KIOSKURL

cat << __startup_kiosk > $XDG_CONFIG_HOME/autostart/startup_kiosk.sh
#!/bin/bash
if [[ -f \$HOME/snap/chromium/common/chromium/Default/Preferences ]]; then
    sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' \$HOME/snap/chromium/common/chromium/Default/Preferences
    sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' \$HOME/snap/chromium/common/chromium/Default/Preferences
fi
/usr/bin/chromium-browser -noerrdialogs --disable-infobars --no-first-run --start-maximized --kiosk $KIOSKURL &
__startup_kiosk

cat << __kiosk_desktop > $XDG_CONFIG_HOME/autostart/kiosk.desktop
[Desktop Entry]
Type=Application
Name=Kiosk
Exec=bash -e -c "source \\\\\$HOME/.config/autostart/startup_kiosk.sh"
__kiosk_desktop

popd > /dev/null

