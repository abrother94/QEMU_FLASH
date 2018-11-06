#!/bin/sh

#arm-linux-gcc -static test.c -o test
arm-linux-gnueabi-gcc -static test.c -o test
echo test | cpio -o --format=newc > testrootfs.img
