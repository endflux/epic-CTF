# epic-CTF Project

## Overview

A Bandit-style SSH wargame hosted in an Ubuntu Docker container. Players progress through levels by solving Linux and security challenges.

## Vision

A Bandit-style SSH wargame for learning Linux and security fundamentals.

Players SSH into a server and solve challenges to find passwords that unlock the next level. No UI — just a shell.

**Goals**
- Teach real skills through hands-on challenges
- Beginner-friendly, scales to intermediate
- Self-hostable with Docker

## Stack

**Server**
- OS: Ubuntu 24.04 inside Docker
- SSH: OpenSSH
- Containerization: Docker

**User Isolation**
- Native Linux users and file permissions
- SUID binaries for levels that require privilege escalation

**Scripting**
- Bash for server setup and level provisioning

## Password Management

Passwords are set via a `.env` file and passed into the container at runtime.

**.env**
```
PASS_LEVEL0=abc123
PASS_LEVEL1=hunter2
PASS_LEVEL2=letmein
PASS_LEVEL3=supersecret
```

**docker-compose.yml** reads `.env` automatically and passes vars to the container.

**setup.sh** reads each `PASS_LEVEL<N>` env var and writes it to `/etc/epic_pass/level<N>`, locked to that user only.

> `.env` is gitignored — passwords never reach GitHub.

## Container IP Display

After starting the containers, players need to know the IP to SSH into. The plan is a small wrapper script (`start.sh`) that brings up the stack and then prints each container's internal IP.

**Possible implementation — `start.sh`**
```bash
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
```

Running `./start.sh` builds the image, starts the container, and prints something like:

```
=== Container IPs ===
  epic-ctf-ctf-server-1 -> 172.18.0.2
=====================
SSH: ssh level0@172.18.0.2 -p 2220
```

> Note: the container IP is the internal Docker bridge IP. From the host machine, `localhost` (or `127.0.0.1`) on port `2220` works just as well via the published port mapping. The internal IP is useful when connecting from other containers on the same network.

**Project Structure update** — add `start.sh` to the root:
```
epic-CTF/
├── start.sh          ← builds + prints container IPs
```

## Docs

- `architecture.md` — how the system is structured and how data flows

## Project Structure

```
epic-CTF/
├── project.md
├── vision.md
├── architecture.md
├── stack.md
├── Dockerfile
├── docker-compose.yml
├── setup.sh          ← creates users, sets permissions
├── start.sh          ← builds image, starts container, prints IPs
└── levels/
    ├── level0/
    │   ├── README
    │   └── challenge files
    ├── level1/
    │   ├── README
    │   └── challenge files
    ├── level2/
    │   ├── README
    │   └── challenge files
    └── level3/
        ├── README
        └── challenge files
```

## Status

- [x] Vision defined
- [x] Architecture outlined
- [x] Stack chosen
- [x] Dockerfile + compose
- [x] Setup script
- [ ] Levels built (READMEs done — puzzles pending)
- [x] `start.sh` — IP display on build
- [ ] End-to-end tested
