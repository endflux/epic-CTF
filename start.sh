#!/bin/bash
LEVELS=4

docker compose up -d --build

IP=$(docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$(docker compose ps -q)")

echo ""
echo "=== SSH Commands ==="
for i in $(seq 0 $((LEVELS - 1))); do
  echo "  ssh level$i@$IP -p 2220"
done
echo "===================="
