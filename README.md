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

9. Open a terminal window and install git:
```
sudo apt install -y git
```

10. Clone the kiosk setup repo:
```
git clone https://github.com/khsoh/kiosk-linux.git kiosk
```

11. Change directory to the repo:
```
cd kiosk
```

12. Source the bootstrap.sh script to install more tools:
```
source bootstrap.sh
```

13. Source the setup_kiosk.sh script to setup the startup environment to run firefox
```
source setup_kiosk.sh
```

### Display and/or touchscreen orientation issues

It is possible that the display may not be in the correct orientation for your hardware.  The following are instructions for fixing this issue in wattOS or Debian-based distributions:

1. Open a terminal window.

2. Check that `/usr/bin/xinput` is present.  If not, then execute: `sudo apt install -y xinput`. `xinput` is required to fix touchscreen orientation.

3. Fix the grub startup display orientation:
    * Use `vim` to edit `/etc/default/grub` : `sudo vim /etc/default/grub`
    * Locate the line that starts with `GRUB_CMDLINE_LINUX` or `GRUB_CMDLINE_LINUX_DEFAULT`
    * Append one of the following string to the existing string:
        - `fbcon=rotate:1`: 90 degrees clockwise orientation
        - `fbcon=rotate:2`: Upside down orientation
        - `fbcon=rotate:3`: 90 degrees counter-clockwise orientation
    * Execute the command: `sudo update-grub`.  
<br/>

4. If the graphical LXDE environment for wattOS is rotated, do the following to fix the issue:
    * Run the following command to identify the display by viewing the list of connected displays:
        - `xrandr -q` 
        - Look for the line that says "connected" to find your display's name (e.g. `DSI-1`)
    * Use `vim` to create a file `~/rotate.sh`
    * Add the following string to end of the file to rotate the screen to the desired orientation:
        - `xrandr --output <DISPLAY> --rotate [right|left|inverted]`
        - save the file
        - Execute: `chmod +x ~/rotate.sh`
    * Use `vim` to edit the file `~/.config/lxsession/LXDE/autostart` and add the following line at the end of the file:
        - `@/full/path/to/rotate.sh` - replacing `/full/path/to` with the appropriate path
    * Reboot the machine to test the changes work.  If the orientation is still not fixed, try inserting `sleep 3` before the `xrandr` command in `rotate.sh`.  
<br/>

5. If the touchscreen orientation needs to be corrected, do the following steps:
    * Identify the touchscreen device by executing `xinput --list`.  Note the device name string.
    * Use `vim` to edit the `rotate.sh` file that was created in the previous step.
    * Add the following line at the end of the file:
        - `xinput set-prop "Your touchsreen device name" --type-float "Coordinate Transformation Matrix" <orientation>`
    * The `<orientation>` should be one of the following:
        - `0 -1 1 1 0 0 0 0 1`  : 90 degrees clockwise rotation
        - `-1 0 1 0 -1 1 0 0 1` : 180 degrees rotation
        - `0 1 0 -1 0 1 0 0 1`  : 90 degrees counter-clockwise rotation

