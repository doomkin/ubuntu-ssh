#
# doomkin/ubuntu-ssh Dockerfile
#
# Build: sudo docker build -t doomkin/ubuntu-ssh .
# Run:   sudo docker run --name ssh -it -d -P doomkin/ubuntu-ssh
# Login: eval `ssh-agent -s`; ssh-add ssh/id_rsa; ssh root@localhost -p `sudo docker port ssh 22 | cut -d":" -f2`
#

FROM ubuntu:14.04
MAINTAINER Pavel Nikitin <p.doomkin@ya.ru>

# Set the noninteractive frontend
ENV DEBIAN_FRONTEND noninteractive

# SSH key without password
ADD ssh/id_rsa.pub /root/.ssh/authorized_keys

# Install essentials
RUN apt-get update; \
    apt-get install -y apt-utils debconf-utils iputils-ping wget curl mc htop build-essential ssh; \
    apt-get clean; \
    cd /tmp; \
    wget http://downloads.sourceforge.net/project/p7zip/p7zip/9.38.1/p7zip_9.38.1_src_all.tar.bz2; \
    tar jxf p7zip_9.38.1_src_all.tar.bz2; \
    cd /tmp/p7zip_9.38.1; \
    make; \
    /tmp/p7zip_9.38.1/install.sh; \
    rm -fr /tmp/*; \
    locale-gen en_US.UTF-8; update-locale LANG=en_US.UTF-8; \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config; \
    sed -i 's/PermitRootLogin yes/PermitRootLogin without-password/' /etc/ssh/sshd_config; \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd; \
    chmod 700 /root/.ssh; chmod 600 /root/.ssh/authorized_keys; \
    sed -i 's/^exit 0/service ssh start\nexit 0/' /etc/rc.local

EXPOSE 22

# Default command
CMD /etc/rc.local; bash
