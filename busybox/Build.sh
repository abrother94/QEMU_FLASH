#!/bin/sh
make clean
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-
cp busybox ../rootfs/bin
cd ../rootfs
sudo ./MKRFS.sh
