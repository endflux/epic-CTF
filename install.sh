#!/bin/bash
set -e

echo "=== Removing old Docker packages ==="
apt remove -y docker docker-engine docker.io containerd runc docker-compose 2>/dev/null || true

echo "=== Installing dependencies ==="
apt update
apt install -y ca-certificates curl gnupg

echo "=== Adding Docker's official GPG key ==="
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo "=== Adding Docker apt repository ==="
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "=== Installing Docker Engine + Compose ==="
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

systemctl enable --now docker

echo ""
echo "=== Done ==="
echo "Run ./start.sh to build and start the CTF server."
