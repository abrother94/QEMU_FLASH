# QEMU_FLASH

<br>This QEMU emulate ARM versatile hardware, and start from u-boot to runtime linux kernel (4.2) 
environment from flash.
<br>It use cross-compile from ONL docker image (Debian jesse with arm-linux-eabi-) and its library.
<br>You need have docker/container build environment to build whole code.

1. ./One_punch_build.sh

    Can pull docker images and build all at one time.

or 

1. ./into_docker.sh
2. ./Build.sh
3. ./Run-flash.sh
   can start from u-boot to kernel
   
   or
   
4. ./Run-kernel.sh
   to enter kernel directlly.
5. ./Run-uboot.sh
   to enter uboot alone.
   
 
