#!/bin/sh
make distclean 
make versatilepb_config
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-
cp u-boot.bin ../
cp u-boot ../

