#!/bin/bash
docker compose up -d --build

echo ""
echo "=== Container IPs ==="
docker compose ps -q | while read id; do
  name=$(docker inspect --format '{{.Name}}' "$id" | sed 's|/||')
  ip=$(docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$id")
  echo "  $name -> $ip"
done
echo "====================="
echo "SSH: ssh level0@<ip> -p 2220"
