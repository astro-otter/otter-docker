# syntax=docker/dockerfile:1
FROM ubuntu:22.04

# move into the home directory
RUN mkdir /home/default-user/
RUN mkdir /home/default-user/astro-otter
RUN mkdir /home/default-user/otter-web

# copy over the otter, otterdb, and examples
ADD otter /home/default-user/astro-otter
ADD otter-web /home/default-user/otter-web
ADD examples /home/default-user/

### Install API

# working directory for installs
WORKDIR /home/default-user/astro-otter/

# install dependences
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    emacs \
    git

RUN pip install --upgrade pip
RUN pip install --upgrade setuptools
RUN pip install --no-cache-dir $(pwd)

### Start the website server

WORKDIR /home/default-user/otter-web
RUN pip install --no-cache-dir $(pwd)
RUN python3 start.py