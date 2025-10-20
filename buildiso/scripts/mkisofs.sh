#!/bin/bash

FULLDATE=$(env TZ="Asia/Singapore" date +"%Y%m%d-%H%M%S%2N")
IFS='-' read -r STRDATE STRTIME <<< "$FULLDATE"

sudo xorriso -as mkisofs -R -r -J -joliet-long -l -cache-inodes -iso-level 3 -A "Debian Live" -publisher "ZBAV Tech Lead" -V "ZBAV_KIOSK" --modification-date=$STRDATE$STRTIME -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e boot/grub/efi.img -no-emul-boot -isohybrid-gpt-basdat -isohybrid-apm-hfsplus -o $1 $2
