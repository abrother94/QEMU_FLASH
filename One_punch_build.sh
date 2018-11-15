#!/bin/bash
USERNAME=`whoami`
uid=`id -u`
gid=`id -g`

QEMU_CONTAINER=`docker ps -a | grep QEMU-One-Punch | awk '{print $1}'`
if [ "${QEMU_CONTAINER}" == "" ];then
    # do not have docker image, pull it.
    PWD=`pwd`
    docker run --privileged  -i -t -e DOCKER_IMAGE=opennetworklinux/builder8:1.9 --name QEMU-One-Punch -d -v /lib/modules:/lib/modules -v ${PWD}:${PWD} -e USER=${USERNAME} --net host -w ${PWD} -e HOME=/home/${USERNAME} -v /home/${USERNAME}:/home/${USERNAME} opennetworklinux/builder8:1.9 /bin/docker_shell --user ${USERNAME}:1000 -c bash
    docker exec QEMU-One-Punch /bin/docker_shell -c "./Build.sh;sudo chown -R ${USERNAME}:${gid} ./"
    `sudo chown -R ${USERNAME}:${gid} ./`    
    docker attach QEMU-One-Punch
else
    docker start QEMU-One-Punch 
    docker exec QEMU-One-Punch /bin/docker_shell -c "./Build.sh;sudo chown -R ${USERNAME}:${gid} ./"
    `sudo chown -R ${USERNAME}:${gid} ./`      
    docker attach QEMU-One-Punch    
fi

