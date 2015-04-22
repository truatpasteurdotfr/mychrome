#!/bin/sh
XSOCK=/tmp/.X11-unix
XAUTH=`mktemp`
xauth nlist ${DISPLAY}| sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

docker run --rm -t \
    --net host \
    --cpuset 0 \
    --memory 512mb \
 -v $XSOCK:$XSOCK \
 -v $XAUTH:$XAUTH \
 -v /dev/dri:/dev/dri -v /dev/shm:/dev/shm \
 -v /dev/snd:/dev/snd \
 -e XAUTHORITY=$XAUTH \
 -e DISPLAY=$DISPLAY \
 --privileged \
 truhuynh/mychrome:centos7

