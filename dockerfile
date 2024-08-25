# syntax=docker/dockerfile:1

FROM ubuntu:latest

# Set the working directory
WORKDIR /opt/jaegerLe

USER root

# Consolidate all necessary commands into a single RUN
RUN echo 'root:admin' | chpasswd && \
    useradd -rm -d /home/suuser -s /bin/bash -g root -G sudo -u 1001 suuser && \
    echo 'suuser:suuser' | chpasswd && \
    useradd -rm -d /home/admin -s /bin/bash -g root -G sudo -u 1002 admin && \
    echo 'admin:admin' | chpasswd && \
    apt-get update && apt-get install -y \
    vim wget sudo curl python3.12 \
    openssh-server iproute2 iputils-ping && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    echo "HostKeyAlgorithms ssh-dss,ecdsa-sha2-nistp256,ssh-ed25519" >> /etc/ssh/ssh_config && \
    echo "KexAlgorithms diffie-hellman-group1-sha1,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1,ssh-rsa" >> /etc/ssh/ssh_config && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /opt/jaegerLe && \
    cp -r ./dist/jaegerLe /opt/jaegerLe/

# Expose necessary ports
EXPOSE 8080 22

# Start SSH and run the main application
CMD service ssh start && ./jaegerLe --config /opt/jaegerLe/config/jaegerle-config.yaml
