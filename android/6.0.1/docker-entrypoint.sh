#!/usr/bin/env bash
set -e -u -o pipefail

mkdir -p /android/src
cd /android/src
repo init -u https://github.com/hardkernel/android.git -b s905_6.0.1_master
repo sync
repo start s905_6.0.1_master --all

export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-
export PATH=/opt/gcc-linaro-aarch64-linux-gnu-4.9-2014.09_linux/bin:$PATH
export PATH=/opt/toolchains/gcc-linaro-arm-none-eabi-4.8-2014.04_linux/bin:$PATH
export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

source build/envsetup.sh
lunch odroidc2-eng-32
make -j4 selfinstall
