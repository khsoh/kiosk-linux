#!/bin/sh

ROTATE=$(cat /proc/cmdline|/bin/sed -r -n -e 's/.*\sfbcon=rotate:(.).*/\1/p')
TSDEV=$(udevadm info --export-db | awk '/ID_INPUT_TOUCHSCREEN=1/' RS='' | grep "^E: NAME=" | cut -d '"' -f2)

if [ "$ROTATE" = "1" ]; then
	xrandr -o right
	if [ ! -z ${TSDEV+x} ]; then
		xinput set-prop "$TSDEV" --type=float "Coordinate Transformation Matrix" 0 -1 1 1 0 0 0 0 1
	fi
elif [ "$ROTATE" = "3" ]; then
	xrandr -o left
	if [ ! -z ${TSDEV+x} ]; then
		xinput set-prop "$TSDEV" --type=float "Coordinate Transformation Matrix" 0 1 0 -1 0 1 0 0 1
	fi
elif [ "$ROTATE" = "2" ]; then
	xrandr -o inverted
	if [ ! -z ${TSDEV+x} ]; then
		xinput set-prop "$TSDEV" --type=float "Coordinate Transformation Matrix" -1 0 1 0 -1 1 0 0 1
	fi
fi

