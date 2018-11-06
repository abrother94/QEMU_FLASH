#!/bin/bash

# Support kernel version
# 3.16.39 3.10.102 4.2.1


VER=$1

if [ ! -f ./linux-${VER}.tar.gz ];then  

    VER=${1}
    if [[ ${VER:0:1} == "3" ]] ; then
        wget http://ftp.ntu.edu.tw/linux/kernel/v3.x/linux-${VER}.tar.gz
    elif [[ ${VER:0:1} == "4" ]];then
        wget http://ftp.ntu.edu.tw/linux/kernel/v4.x/linux-${VER}.tar.gz
    fi

    tar zxvf linux-${VER}.tar.gz
fi

. S1.sh
