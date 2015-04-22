FROM centos:centos7
MAINTAINER Tru Huynh <tru@pasteur.fr>
#
# purpose: running Google Chrome on CentOS-7 as non root user
#
# build with:
# $ docker build --rm -t truhuynh/mychrome:centos7 .
#
# run without permanent volume storage:
# $ SOCK=/tmp/.X11-unix
# $ XAUTH=`mktemp`
# $ xauth nlist ${DISPLAY}| sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
# $ docker run -t \
#    --net host \
#    --memory 512mb \
# -v $XSOCK:$XSOCK \
# -v $XAUTH:$XAUTH \
# -v /dev/dri:/dev/dri -v /dev/shm:/dev/shm \
# -v /dev/snd:/dev/snd \
# -e XAUTHORITY=$XAUTH \
# -e DISPLAY=$DISPLAY \
# --privileged \
# truhuynh/mychrome:centos7
#
# the permanent storage is mounted at ~/docker/mychrome
# you only need to match the uid/gid in the run.sh file
# and to add to the previous lines:
#  -v ~/docker/mychrome:/home/centos

RUN yum -y update; yum clean all
RUN yum -y install mesa-dri-drivers libexif libcanberra-gtk2 libcanberra; yum clean all

ADD https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm /root/google-chrome-stable_current_x86_64.rpm
RUN yum -y install /root/google-chrome-stable_current_x86_64.rpm; yum clean all
RUN dbus-uuidgen > /etc/machine-id
# adapt this run.sh script to match your uid/gid
COPY run.sh /run.sh
CMD ["/run.sh"]

