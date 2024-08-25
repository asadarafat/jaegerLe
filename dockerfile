# Use Red Hat Universal Base Image (UBI) as a parent image
FROM registry.access.redhat.com/ubi8/ubi

# Consolidate all commands into a single RUN to minimize layers
RUN echo 'root:admin' | chpasswd && \
    useradd -rm -d /home/suuser -s /bin/bash -g root -G wheel -u 1001 suuser && \
    echo 'suuser:suuser' | chpasswd && \
    useradd -rm -d /home/admin -s /bin/bash -g root -G wheel -u 1002 admin && \
    echo 'admin:admin' | chpasswd && \
    microdnf update && \
    microdnf install -y openssh-server iproute iputils vim wget sudo curl rsyslog python3 && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    echo "HostKeyAlgorithms ssh-dss,ecdsa-sha2-nistp256,ssh-ed25519" >> /etc/ssh/ssh_config && \
    echo "KexAlgorithms diffie-hellman-group1-sha1,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1,ssh-rsa" >> /etc/ssh/ssh_config && \
    microdnf clean all && \
    rm -rf /var/cache/yum && \
    mkdir -p /opt/jaegerLe && \
    # Copy the pre-built binary and config files into the container
    cp -r /path/to/dist/jaegerLe /path/to/dist/config /opt/jaegerLe/

# Set the working directory inside the container
WORKDIR /opt/jaegerLe

# Command to run the binary
CMD ["./jaegerLe"]
