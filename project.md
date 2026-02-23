# epic-CTF Project

## Overview

A Bandit-style SSH wargame hosted on a self-managed Fedora VM. Players progress through levels by solving Linux and security challenges.

## Vision

A Bandit-style SSH wargame for learning Linux and security fundamentals.

Players SSH into a server and solve challenges to find passwords that unlock the next level. No UI — just a shell.

**Goals**
- Teach real skills through hands-on challenges
- Beginner-friendly, scales to intermediate
- Self-hostable with Docker

## Stack

**Server**
- OS: Debian (slim) inside Docker
- Host: Fedora VM
- SSH: OpenSSH
- Containerization: Docker

**User Isolation**
- Native Linux users and file permissions
- SUID binaries for levels that require privilege escalation

**Scripting**
- Bash for server setup and level provisioning

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
- [ ] End-to-end tested
