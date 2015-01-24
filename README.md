## doomkin/ubuntu-ssh Dockerfile


This repository contains **Dockerfile** of [Ubuntu](http://www.ubuntu.com/) for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/dockerfile/ubuntu/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).


### Base Docker Image

* [doomkin/ubuntu](https://registry.hub.docker.com/u/doomkin/ubuntu/)


### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/doomkin/ubuntu-ssh/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull doomkin/ubuntu-ssh`

3. Alternatively, you can build an image from Dockerfile: `docker build -t="doomkin/ubuntu-ssh" github.com/doomkin/ubuntu-ssh`


### Run

    sudo docker run --name ubuntu-ssh -it -d -P doomkin/ubuntu-ssh

### Login

    ssh-agent -s
    ssh-add ssh/id_rsa
    ssh root@localhost -p `sudo docker port ubuntu-ssh 22 | cut -d":" -f2`
