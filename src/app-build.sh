#!/bin/sh
arm-linux-gnueabi-gcc -g test.c -o test  
cp test ../rootfs/bin/
cd ../rootfs/
MKRFS.sh
