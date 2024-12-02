# otter-docker
Code to setup and install the otter docker container.

# Docker Installation
## Install Docker
* Linux: https://docs.docker.com/desktop/install/linux-install/
* macOS: https://docs.docker.com/desktop/install/mac-install/
* Windows: https://docs.docker.com/desktop/install/windows-install/

## Building the Docker Container
There are two aspects to this project, the database/API server docker container (hosted at https://github.com/astro-otter/otterdb)
and the webapp docker (hosted at https://github.com/astro-otter/otter-web). Both containers need to be started and connected as part of a docker network.
This readme will walk you through the commands needed to do this.

### Linux/macOS
First, we need to create a docker network
```
docker network create otter-net
```

Then, to start the database/API server run
```
docker run --network otter-net noahfranz13/otterdb 
```
Next, in a different terminal, run the following command to get the backend database
```
docker run -p 8080:8080 --network otter-net noahfranz13/astro-otter
```

Which will allow you to open the web app at the url it displays and play around with OTTER!

To also install the python API to query your local version of the OTTER database use
```
git clone https://github.com/astro-otter/otter.git
cd otter
python3 -m pip install .
```

### FAQ

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

**Note 3**: If you get an error like "otter-persist is already in use" that means you need to delete the existing docker containers. To do this, navigate to the "otterdb" directory and run "./clean.sh".

### Windows
If you use wsl2 (I think that's the only way to run docker on windows from the
command line) just go and follow the instructions for Linux/macOS and it should
just work! Please raise an issue if it doesn't (I can't test this).

# Kubernetes Installation
## Basic Kubernetes Setup
For those that do not have kubernetes setup locally, you will need to follow these steps in general:
1. Install and setup a local kubernetes cluster. I recommend using minikube: https://kubernetes.io/docs/tasks/tools/#minikube
2. Install `kubectl`: https://kubernetes.io/docs/tasks/tools/#kubectl
3. Depending on which cluster package you are using, start it and open a tunnel to the cluster.

## Installing OTTER in the Kubernetes Cluster
This repo also stores a helm chart to install the otter application on a kubernetes cluster. Since every kubernetes cluster is different,
you will need to adjust the configuration settings in `otter-helm-chart/values-template.yaml`, including your chosen usernames and passwords,
and then run
```
cp otter-helm-chart/values-template.yaml otter-helm-chart/values.yaml
```
From here, you can install OTTER on the kubernetes cluster with
```
helm install otter otter-helm-chart
```
