FROM debian
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install qemu-kvm *zenhei* xz-utils dbus-x11 curl firefox-esr gnome-system-monitor mate-system-monitor  git xfce4 xfce4-terminal tightvncserver wget   -y
RUN wget https://github.com/novnc/noVNC/archive/refs/tags/v1.2.0.tar.gz
RUN curl -LO https://proot.gitlab.io/proot/bin/proot
RUN chmod 755 proot
RUN mv proot /bin
RUN tar -xvf v1.2.0.tar.gz
RUN mkdir  $HOME/.vnc
RUN echo 'myvncpw' | vncpasswd -f > $HOME/.vnc/passwd
RUN chmod 600 $HOME/.vnc/passwd
RUN echo 'whoami ' >>/vnc.sh
RUN echo 'cd ' >>/vnc.sh
RUN echo "su -l -c  'vncserver :2000 -geometry 1920x1080' "  >>/vnc.sh
RUN echo 'cd /noVNC-1.2.0' >>/vnc.sh
RUN echo './utils/launch.sh  --vnc localhost:7900 --listen 8900 ' >>/vnc.sh
RUN chmod 755 /vnc.sh
RUN apt update --fix-missing -y
RUN apt upgrade -y
RUN curl -fsSL https://gist.githubusercontent.com/HoshinoNeko/c7da43c4e787fe304ed73fbe130e821c/raw/a12735b12b204ff8b417546e991e3dda757275dc/install-nginx-on-debian&ubuntu.sh | bash
RUN curl -fsSL https://gist.github.com/HoshinoNeko/831475f81473f57245874dc14ddcad22/raw/573e5b5fcd6146845ee1e3c1445e36bdcdb911b8/install-speedtest.sh | bash
RUN apt install -y python3 python3-pip golang
EXPOSE 8900
CMD  /vnc.sh
