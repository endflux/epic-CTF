#!/bin/bash
set -e

echo "=== Installing dependencies ==="

sudo apt update
sudo apt install -y docker.io docker-compose-plugin

sudo systemctl enable --now docker

echo ""
echo "=== Done ==="
echo "Run ./start.sh to build and start the CTF server."
