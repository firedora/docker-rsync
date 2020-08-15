# docker-rsync

## Introduction

Dockerfile to build [rsync](https://rsync.samba.org/).

Rsync, which stands for “remote sync”, is a remote and local file synchronization tool. It uses an algorithm that minimizes the amount of data copied by only moving the portions of files that have changed.

## Installation

Automated builds of the image are available on [Dockerhub](https://hub.docker.com/) and is the recommended method of installation.

```sh
docker pull kepuro/rsync:latest
```

Alternatively you can build the image locally.

```sh
docker build -t some-rsync https://github.com/kepuro/docker-rsync.git
```

## Quick Start

Step 1. Launch a rsync server container on host

```sh
docker run --name some-rsync -d \
	-v /path/to/local:/data \
	-p 2200:22 \
	kepuro/rsync:latest \
	server
```

Step 2. Add SSH auth key

```sh
docker exec some-rsync add-auth-key SSH-AUTH-KEY
```

Step 3. Transfer file form local to remote host

```sh
rsync -e 'ssh -p 2200' -avzP --delete public/ [user]@[host]:/data/website
```
