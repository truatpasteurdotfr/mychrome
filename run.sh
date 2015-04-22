#!/bin/sh
# example: adapt the values to match your uid/gid 
# $ id
# uid=2765(tru) gid=400(Bis) groups=400(Bis),10(wheel),395(docker),398(vboxusers)
/usr/sbin/groupadd -g 400 centos_group
/usr/sbin/useradd  -u 2765 -g centos_group -c "Docker image user" centos
chown centos /home/centos
echo $DISPLAY
su -l centos -c "DISPLAY=$DISPLAY /usr/bin/google-chrome-stable --no-sandbox "
