# otter-docker
Code to setup and install the otter docker container.

# Installation
## Install Docker
* Linux: https://docs.docker.com/desktop/install/linux-install/
* macOS: https://docs.docker.com/desktop/install/mac-install/
* Windows: https://docs.docker.com/desktop/install/windows-install/

## Building the Docker Container
### Linux/macOS
Run the following command to get the docker container from this GitHub
```
docker build https://github.com/astro-otter/otter-docker.git#main -t astro-otter
```
Then you can run the image using
```
docker run -it -p 8989:8989  astro-otter
```
Which will allow you to open the jupyter lab server at the url it displays and play around with OTTER!

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