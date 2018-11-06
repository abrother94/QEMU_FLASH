#/bin/bash

#Build Qemu 2.6

tar zxvf rootfs.tar.gz

cd qemu
./Build.sh "2.6.0" 
cd ../

#Build uboot

cd u-boot-armdev.git/
./Build.sh 
cd ../

#Build kernel
cd kernel
./Build.sh "4.2.1" 

cd ../

#Build busybox
cd busybox
./Build.sh
