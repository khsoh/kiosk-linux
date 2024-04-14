#!/usr/bin/env bash

SCRIPTNAME=$(readlink -f ${BASH_SOURCE[0]})
pushd "$(dirname $SCRIPTNAME)" > /dev/null

if [[ ! -d /opt/kiosk ]]; then
    sudo mkdir -p /opt/kiosk
fi

cat << __cleanup_kiosk > ./cleanup_kiosk.sh
#!/bin/bash
if [[ -f \$HOME/snap/chromium/common/chromium/Default/Preferences ]]; then
    sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' \$HOME/snap/chromium/common/chromium/Default/Preferences
    sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' \$HOME/snap/chromium/common/chromium/Default/Preferences
fi
__cleanup_kiosk
sudo mv -f ./cleanup_kiosk.sh /opt/kiosk/cleanup_kiosk.sh
sudo chown root /opt/kiosk/cleanup_kiosk.sh
sudo chgrp root /opt/kiosk/cleanup_kiosk.sh
sudo chmod +x /opt/kiosk/cleanup_kiosk.sh

read -p "Kiosk URL: " KIOSKURL

cat << __kioskservice > ./kiosk.service
[Unit]
Description=Chromium Kiosk
Wants=graphical.target
After=graphical.target

[Service]
Environment=DISPLAY=:0
Type=simple
ExecStartPre=/opt/kiosk/cleanup_kiosk.sh
ExecStart=/usr/bin/chromium-browser -noerrdialogs --disable-infobars --no-first-run --start-maximized --kiosk $KIOSKURL
Restart=no
User=$USER
Group=$USER

[Install]
WantedBy=graphical.target
__kioskservice
sudo mv -f ./kiosk.service /lib/systemd/system/kiosk.service
sudo chown root /lib/systemd/system/kiosk.service
sudo chgrp root /lib/systemd/system/kiosk.service
sudo systemctl enable kiosk

popd > /dev/null

