#!/bin/bash

VER=$1

if [ $VER == "" ];then
    echo "2.6.0 support only"
    exit
fi

if [ ! -f ./qemu-${VER}.tar.xz ];then  
wget https://download.qemu.org/qemu-${VER}.tar.xz
fi
tar xf qemu-${VER}.tar.xz
cp ./versatilepb.c ./qemu-${VER}/hw/arm/versatilepb.c
cp Build-in.sh qemu-${VER}/Build.sh
cd qemu-${VER}
./Build.sh
