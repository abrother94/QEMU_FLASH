#/bin/bash
QEMU_CONTAINER=`docker ps -a | grep QEMU | awk '{print $1}'`
if [ "${QEMU_CONTAINER}" == "" ];then
    # do not have docker image, pull it.
    PWD=`pwd`
    docker run --privileged -i -t -e DOCKER_IMAGE=opennetworklinux/builder8:1.9 --name QEMU -v /lib/modules:/lib/modules -v ${PWD}:${PWD} -e USER=voltha --net host -w ${PWD} -e HOME=${PWD} -v ${PWD}:${PWD} opennetworklinux/builder8:1.9 /bin/docker_shell --user qemu:1000 -c bash
else
    # into exist docekr env.
    docker start QEMU;docker attach QEMU
fi
