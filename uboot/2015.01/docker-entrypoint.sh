#!/usr/bin/env bash
set -e -u -o pipefail

targetcard=$1

source ~/.bashrc
pacman -Sy --noconfirm --noprogress 
mkdir -p /uboot/src
cd /uboot/src
aarch64-elf-gcc -v
git clone https://github.com/hardkernel/u-boot.git -b odroidc2-v2015.01 .
ARCH=arm CROSS_COMPILE=aarch64-elf- make odroidc2_config
ARCH=arm CROSS_COMPILE=aarch64-elf- make
ls fip/gxb/
#cp fip/gxb/u-boot.bin /uboot/out
cp sd_fuse/bl1.bin.hardkernel /uboot/out
cp fip/gxb/u-boot.bin /uboot/out

if [[ -n "$targetcard" ]]; then
    cd sd_fuse
    ./sd_fuzing.sh $targetcard
else
    echo "Build Only"
fi

