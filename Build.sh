#/bin/bash

#Build Qemu 2.6

SUDOCHK=`sudo -v`

if [ "${SUDOCHK}" != "" ];then
    echo "You need have sudo right to build this...Sorry!"
fi

echo "extract sample rootf"
sudo tar zxvf rootfs.tar.gz

cd qemu
echo "Build QEMU...."
./Build.sh "2.6.0" 
cd ../

#Build uboot
echo "Build u-boot...."
cd u-boot-armdev.git/
./Build.sh 
cd ../

#Build kernel
cd kernel
echo "Build kernel...."
./Build.sh "4.2.1" 

cd ../

#Build busybox
echo "Build busybox...."
cd busybox
./Build.sh
