#!/bin/sh


cd linux-${VER}

cp ../clean.sh ./

./clean.sh

cp ../../config/config-${VER} ./.config
export INSTALL_MOD_PATH=../../rootfs

make -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- uImage
make -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- -C ./ M=./samples modules
#make -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- M=./samples modules_install
#arm-linux-gnueabi-objdump -D vmlinux > dump.log
#arm-linux-gnueabi-objdump -x vmlinux > xdump.log
#arm-linux-gnueabi-gcc -o hello hello.c
#arm-linux-gnueabi-objdump -D hello > hello.log
#chmod 777 hello
cp hello ../../rootfs/
cp arch/arm/boot/zImage ../../
cp arch/arm/boot/uImage ../../

cd ../../rootfs
sudo ./MKRFS.sh

#cp ./samples/kobject/*.ko ../../rootfs/lib/modules/2.6.33

#./qemu-system-arm -M versatilepb -m 128M -kernel zImage -nographic
