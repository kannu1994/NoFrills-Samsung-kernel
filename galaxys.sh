#!/bin/sh

echo "copying config for SGS"
cp arch/arm/configs/aries_galaxysmtd_defconfig .config

echo "building kernel"
. drivers.sh make -j8

echo "creating boot.img"
~/android/aosp/device/samsung/aries-common/mkshbootimg.py release/boot.img arch/arm/boot/zImage ~/android/aosp/out/target/product/galaxysmtd/ramdisk.img ~/android/aosp/out/target/product/galaxysmtd/ramdisk-recovery.img

echo "launching packaging script"
./release/doit.sh
