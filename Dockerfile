# syntax=docker/dockerfile:1
FROM ubuntu:22.04

# move into the home directory
RUN mkdir /home/default-user/
RUN mkdir /home/default-user/data
RUN mkdir /home/default-user/astro-otter

# copy over the otter and otterdb
ADD otter /home/default-user/astro-otter
ADD otterdb/.otter /home/default-user/data

# working directory for installs
WORKDIR /home/default-user/astro-otter/

# install dependences
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    emacs

RUN pip install jupyterlab
RUN pip install --upgrade pip
RUN pip install --upgrade setuptools
RUN pip install --no-cache-dir $(pwd)

# move into a user working directory
WORKDIR /home/default-user
