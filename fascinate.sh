#!/bin/sh

echo "copying config for FASCINATE"
cp arch/arm/configs/fascinatemtd_defconfig .config

echo "building kernel"
. drivers.sh make -j8

echo "creating boot.img"
~/android/aosp/device/samsung/aries-common/mkshbootimg.py release/boot.img arch/arm/boot/zImage ~/android/aosp/out/target/product/fascinatemtd/ramdisk.img ~/android/aosp/out/target/product/fascinatemtd/ramdisk-recovery.img

echo "launching packaging script"
./release/doit_fascinate.sh
