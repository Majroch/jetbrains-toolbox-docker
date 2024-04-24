Jetbrains Toolbox Docker
========================

## Overview

This projects aims to bring Jetbrains Toolbox into containerized environment, so all applications can be run on any Linux environment.

## Usage

To get started, you'll need to have:

- Docker ([Official docker site](https://docs.docker.com/engine/install/))
- Docker compose ([Official docker site](https://docs.docker.com/compose/install/))
- Fuse (probably package named `fuse` or `libfuse`)
- Git

To use this project, run:

```bash
git clone https://github.com/Majroch/jetbrains-toolbox-docker
cd jetbrains-toolbox-docker
docker compose up -d
```

After that, Toolbox welcome window should pop up on screen.

