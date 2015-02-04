#
# doomkin/ubuntu-ssh Dockerfile
#
# Based on:
# https://github.com/doomkin/ubuntu
# https://github.com/shufo/docker-sshd
#

FROM doomkin/ubuntu
MAINTAINER Pavel Nikitin <p.doomkin@ya.ru>

# Set the noninteractive frontend
ENV DEBIAN_FRONTEND noninteractive

# Add ssh authorized keys with empty password
ADD ssh/id_rsa.pub /root/.ssh/authorized_keys

RUN echo "Updating packages..." && \
    apt-get update && apt-get upgrade -y && \
    echo "Installing OpenSSH server..." && \
    apt-get install -y openssh-server && \
    sed -i 's/#PasswordAuthentication no/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed -i 's/PermitRootLogin yes/PermitRootLogin without-password/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys && \
    echo "Cleaning..." && \
    rm -rf /var/lib/apt/lists/*

# Expose sshd port
EXPOSE 22

# Run sshd daemon
CMD ["/usr/sbin/sshd", "-D"]
