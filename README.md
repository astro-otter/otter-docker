# otter-docker
Code to setup and install the otter docker container.

# Installation
## Install Docker
* Linux: https://docs.docker.com/desktop/install/linux-install/
* macOS: https://docs.docker.com/desktop/install/mac-install/
* Windows: https://docs.docker.com/desktop/install/windows-install/

## Building the Docker Container
There are two aspects to this project, the database/API server docker container (hosted at https://github.com/astro-otter/otterdb)
and the webapp docker (hosted in this repo). Both containers need to be started and connected as part of a docker network.
This readme will walk you through the commands needed to do this.

### Linux/macOS
First, we need to create a docker network
```
docker network create otter-net
```

Then, to start the database/API server run
```
git clone https://github.com/astro-otter/otterdb.git
cd otterdb
./build.sh
```

Next, run the following command to get the docker container from this GitHub
```
docker build https://github.com/astro-otter/otter-docker.git#main -t astro-otter
```

Finally, you can run the image using
```
docker run -it -p 8989:8989 --network otter-net astro-otter
```
Which will allow you to open the web app at the url it displays and play around with OTTER!

**Note 1**: You may need to run the above docker commands either as root user or using `sudo ...`, it depends on your
docker installation.

**Note 2**: On macOS, it seems like the `.docker` directory is not writeable by default. If you are getting errors like
```
Dockerfile:1
--------------------
   1 | >>> # syntax=docker/dockerfile:1
   2 |     FROM ubuntu:22.04
   3 |
--------------------
ERROR: failed to solve: failed to resolve source metadata for docker.io/docker/dockerfile:1: error getting credentials - err: exit status 1, out: ``
```
try running `sudo chown -R $(id -u):$(id -g) $HOME/.docker` and then rerunning the above two commands.

### Windows
If you use wsl2 (I think that's the only way to run docker on windows from the
command line) just go and follow the instructions for Linux/macOS and it should
just work! Please raise an issue if it doesn't (I can't test this).