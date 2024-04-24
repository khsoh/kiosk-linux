# kiosk-linux
Kiosk setup for Linux.

This repository contains code to support the setting up of a Linux-based kiosk.  The
following distributions are supported:

- [Ubuntu desktop](https://ubuntu.com/download/desktop/thank-you?version=22.04.4&architecture=amd64)
- [Ubuntu-flavoured distribution](https://ubuntu.com/desktop/flavours)
- [wattOS](https://www.planetwatt.com) - Version R13
- [peppermintOS](https://peppermintos.com)

Note that [Xubuntu](https://xubuntu.org) is probably the lightest Ubuntu flavour that you can use for
a kiosk application.

## Setup
1. Download **ONE** of the following ISO image:
- [Ubuntu desktop](https://ubuntu.com/download/desktop/thank-you?version=22.04.4&architecture=amd64)
- [Ubuntu-flavoured distribution](https://ubuntu.com/desktop/flavours)
- [wattOS](https://www.planetwatt.com)
- [peppermintOS](https://peppermintos.com)

2. Make a bootable USB stick.  If you are not sure how to do this, follow these 
[instructions](https://help.ubuntu.com/community/Installation/FromUSBStick).

3. Plug in the USB stick into your mini-PC and boot from it to install the Linux distribution
Most of the the choices are fairly straight-forward.

4. During the setup should make user auto-login

5. After setup has completed, reboot to autologin into graphical environment

6. After booting up into the GUI desktop the first time, it is possible for some distributions
(the more advanced Ubuntu flavours) that a GUI notification may pop up to show the
updates that you should perform.  Execute those system updates first.

NOTE: The wattOS and Xubuntu distributions as of 22.04 do **NOT** have such an automated GUI 
notification tool present.


7. Press <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>T</kbd> to open a terminal window.  Then install git:
```
sudo apt install -y git
```

8. Clone the kiosk setup repo:
```
git clone https://github.com/khsoh/kiosk-linux.git kiosk
```

9. Change directory to the repo:
```
cd kiosk
```

10. Source the bootstrap.sh script to install more tools:
```
source bootstrap.sh
```

11. Source the setup_kiosk.sh script to setup the startup environment to run firefox
```
source setup_kiosk.sh
```

