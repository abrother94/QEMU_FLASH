#/bin/bash
#Build Qemu 2.6
PATH=$PATH:$HOME/bin:./:/bin/:/usr/bin/
export PATH

SUDOCHK=`sudo -v`

if [ "${SUDOCHK}" != "" ];then
    echo "You need have sudo right to build this...Sorry!"
fi

#pre-install
sudo apt-get install libglib2.0-dev

echo "extract sample rootf"
sudo tar zxvf rootfs.tar.gz

cp -rf /lib/arm-linux-gnueabi/* rootfs/lib/

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
