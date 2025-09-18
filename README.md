# kiosk-linux
Kiosk setup for Linux.

This repository contains code to support the setting up of a Linux-based kiosk.  The
following distributions are supported:

- (Recommended) [wattOS](https://www.planetwatt.com) - Version R13
- [Ubuntu desktop](https://ubuntu.com/download/desktop/thank-you?version=22.04.4&architecture=amd64)
- [Ubuntu-flavoured distribution](https://ubuntu.com/desktop/flavours)
- [peppermintOS](https://peppermintos.com)

Note that [Xubuntu](https://xubuntu.org) is probably the lightest Ubuntu flavour that you can use for
a kiosk application.

## Setup
1. Download **ONE** of the following ISO image:
- (Recommended) [wattOS](https://www.planetwatt.com)
- [Ubuntu desktop](https://ubuntu.com/download/desktop/thank-you?version=22.04.4&architecture=amd64)
- [Ubuntu-flavoured distribution](https://ubuntu.com/desktop/flavours)
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
**NOTE**: The wattOS and Xubuntu distributions as of 22.04 do **NOT** have such an automated GUI 
notification tool present.

7. Note that in all distributions, use the keyboard shorcut <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>T</kbd> to open a terminal window.

8. In distributions that do not have a GUI to auto update packages, open a terminal window to update packages:
```
sudo apt update -y
```

9. It is possible that in some hardware, the display orientation during grub startup is rotated.  To fix this: 
    * Open a terminal window
    * Use vim to edit `/etc/default/grub` : `sudo vim /etc/default/grub`
    * Locate the line that starts with `GRUB_CMDLINE_LINUX` or `GRUB_CMDLINE_LINUX_DEFAULT`
    * Append one of the following string to the existing string:
        - `fbcon=rotate:1`: 90 degrees clockwise orientation
        - `fbcon=rotate:2`: Upside down orientation
        - `fbcon=rotate:3`: 90 degrees counter-clockwise orientation
    * Execute the command: `sudo update-grub`.  
<br/>

10. If the LXDE environment for wattOS is rotated, do the following to fix the issue:
    * Open a terminal window
    * Run the following command to identify the display by viewing the list of connected displays:
        - `xrandr -q` 
        - Look for the line that says "connected" to find your display's name (e.g. `DSI-1`)
    * Use vim to create a file `~/rotate.sh`
    * Add the following string to end of the file to rotate the screen to the desired orientation:
        - `xrandr --output <DISPLAY> --rotate [right|left|inverted]`
        - save the file
        - Execute: `chmod +x ~/rotate.sh`
    * Use vim to edit the file `~/.config/lxsession/LXDE/autostart` and add the following line at the end of the file:
        - `@/full/path/to/rotate.sh` - replacing `/full/path/to` with the appropriate path
    * Reboot the machine to test the changes work.  If the orientation is changed, try inserting `sleep 3` before the `xrandr` command in `rotate.sh`.  
<br/>


11. Open a terminal window and install git:
```
sudo apt install -y git
```

12. Clone the kiosk setup repo:
```
git clone https://github.com/khsoh/kiosk-linux.git kiosk
```

13. Change directory to the repo:
```
cd kiosk
```

14. Source the bootstrap.sh script to install more tools:
```
source bootstrap.sh
```

15. Source the setup_kiosk.sh script to setup the startup environment to run firefox
```
source setup_kiosk.sh
```

