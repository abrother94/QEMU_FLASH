#!/bin/sh
make clean
./configure --target-list=arm-softmmu,arm-linux-user
make -j8 ;cp arm-softmmu/qemu-system-arm ../../qemu-system-arm-2.6.0-flash
