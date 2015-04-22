dockerfiles-centos-chrome
=========================

CentOS 7 dockerfile for Google Chrome writing as non-root user on the monted volume

You need to adapt the run.sh file to match you user id/gid.
mkdir -p ~/docker/mychrome # for the permanent storage space

To build:

    # docker build --rm -t truhuynh/chrome:centos7 .

Run the chrome browser inside docker with a permanent storage (in this case ~/docker/mychrome)
~/docker/mychrome will be mapped to /home/centos inside the container, and will provide the permanent storage for chrome.

    # docker run --rm -t --memory 512mb --net host  -e DISPLAY=$DISPLAY -v /dev/dri:/dev/dri -v /dev/shm:/dev/shm -v /dev/snd:/dev/snd -v -v ~/docker/mychrome:/home/centos --privileged  truhuynh/chrome:centos7 

Run a pristine chrome browser inside docker, without any previous configuration:

    # docker run --rm -t --memory 512mb --net host  -e DISPLAY=$DISPLAY -v /dev/dri:/dev/dri -v /dev/shm:/dev/shm -v /dev/snd:/dev/snd --privileged  truhuynh/chrome:centos7 

based on https://blog.jessfraz.com/posts/docker-containers-on-the-desktop.html


Display issue: 
1) [tru@home ~]$ docker run -t truhuynh/mychrome:centos7
[1:1:0417/130908:ERROR:browser_main_loop.cc(171)] Running without the SUID sandbox! See https://code.google.com/p/chromium/wiki/LinuxSUIDSandboxDevelopment for more information on developing with the sandbox on.
[1:1:0417/130908:ERROR:browser_main_loop.cc(217)] Gtk: cannot open display

Please use/adapt the provided scripts at https://github.com/truatpasteurdotfr/mychrome:
mychrome-in-docker+keep-settings.sh and mychrome-in-docker.sh 


