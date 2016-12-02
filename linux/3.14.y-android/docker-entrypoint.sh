#!/usr/bin/env bash
set -e -u -o pipefail

source ~/.bashrc
pacman -Sy --noconfirm --noprogress 
mkdir -p /linux/src
cd /linux/src
aarch64-linux-gnu-gcc -v
git clone --depth 1 https://github.com/hardkernel/linux.git -b odroidc2-3.14.y-android .
#
# drivers/amlogic/wifi/KconfigA
# drivers/amlogic/wifi/Kconfig:26: can't open file “../hardware/wifi/realtek/drivers/8192cu/rtl8xxx_CU/Kconfig”
#
sed '$d' drivers/amlogic/wifi/Kconfig > drivers/amlogic/wifi/Kconfig
ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make odroidc2_defconfig
ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make Image dtbs modules
