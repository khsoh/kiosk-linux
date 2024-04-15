# kiosk-linux
Kiosk setup for Linux.

The `main` branch supports the setting up of a kiosk for [Xubuntu](https://xubuntu.org) distribution.
The `wattos` branch supports the setting up of a kiosk for [wattOS](https://www.planetwatt.com) distribution.

## Setup
1. Download the [Xubuntu ISO](https://xubuntu.org/download) image

2. Make a bootable USB stick.  If you are not sure how to do this, follow these 
[instructions](https://help.ubuntu.com/community/Installation/FromUSBStick).

3. Plug in the USB stick into your mini-PC and boot from it to install Xubuntu.
Most of the the choices are fairly straight-forward.

4. During the setup should make user auto-login

5. After setup has completed, reboot to autologin into graphical environment

6. Press Ctrl-Alt-T to open a terminal window.  Then install git:
```
sudo apt install -y git
```

7. Clone the kiosk setup repo:
```
git clone https://github.com/khsoh/kiosk-linux.git kiosk
```

8. Change directory to the repo:
```
cd kiosk
```

9. Source the bootstrap.sh script to perform installation of more tools:
```
source bootstrap.sh
```

10. Source the setup_kiosk.sh script to setup the startup environment to run chromium
```
source setup_kiosk.sh
```
