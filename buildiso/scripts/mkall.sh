#!/bin/bash

# TO BE RUN IN LINUX SYSTEM
# Purpose: Recompute the SHA256 for live/filesystem.squashfs in sha256sum.txt file 
#          of the ISO image
sudo bash <<EOF
mksquashfs $1 filesystem.squashfs -comp xz -b 1M
mv -f filesystem.squashfs $2/live

pushd $2
FN="./live/filesystem.squashfs"
NEW_HASH=\$(sha256sum \$FN | awk '{print \$1}')

# Replace the checksum for \$FN in sha256sum.txt
sed -i "s|^[a-f0-9]\{64\}  *\$FN|\$NEW_HASH  \$FN|" "sha256sum.txt"
popd

FULLDATE=\$(env TZ="Asia/Singapore" date +"%Y%m%d-%H%M%S%2N")
IFS='-' read -r STRDATE STRTIME <<< "\$FULLDATE"

xorriso -as mkisofs -R -r -J -joliet-long -l -cache-inodes -iso-level 3 -A "Debian Live" -publisher "ZBAV Tech Lead" -V "ZBAV_KIOSK" --modification-date=\$STRDATE\$STRTIME -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e boot/grub/efi.img -no-emul-boot -isohybrid-gpt-basdat -isohybrid-apm-hfsplus -o $3 $2
EOF
