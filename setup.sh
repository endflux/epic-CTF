#!/bin/bash
set -e

LEVELS=4

# Create users and home directories
for i in $(seq 0 $((LEVELS - 1))); do
    useradd -m -s /bin/bash level$i
    echo "level$i:$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 32)" | chpasswd
done

# Create password store
mkdir -p /etc/epic_pass

# Generate passwords for each level and store them
for i in $(seq 0 $((LEVELS - 1))); do
    PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 32)
    echo $PASSWORD > /etc/epic_pass/level$i
    chown level$i:level$i /etc/epic_pass/level$i
    chmod 400 /etc/epic_pass/level$i
done

# Copy challenge files into each user's home directory
for i in $(seq 0 $((LEVELS - 1))); do
    if [ -d /levels/level$i ]; then
        cp -r /levels/level$i/. /home/level$i/
        chown -R level$i:level$i /home/level$i/
    fi
done

# SSH hardening
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
