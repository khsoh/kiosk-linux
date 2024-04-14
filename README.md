# kiosk-xubuntu
Kiosk setup for Xubuntu

## Setup
1. Download and install Xubuntu : [Xubuntu](https://xubuntu.org)

2. Setup should make user auto-login

3. After setup down, reboot to autologin into graphical environment

4. Press Ctrl-Alt-T to open a terminal window.  Then install git:
```
sudo apt install git
```

5. Clone the kiosk setup repo:
```
git clone https://github.com/khsoh/kiosk-xubuntu.git
```

6. Change directory to the repo:
```
cd kiosk-xubuntu
```

7. Source the bootstrap.sh script to perform installation of more tools:
```
source bootstrap.sh
```

8. Source the setup_kiosk.sh script to setup the startup environment to run chromium
```
source setup_kiosk.sh
```
