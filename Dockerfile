# syntax=docker/dockerfile:1
FROM ubuntu:22.04

# move into the home directory
RUN mkdir /home/default-user/
RUN mkdir /home/default-user/data
RUN mkdir /home/default-user/astro-otter

# copy over the otter, otterdb, and examples
ADD otter /home/default-user/astro-otter
ADD otterdb/.otter /home/default-user/data
ADD examples /home/default-user/

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

# move into a user working directory and start jupyter lab when it is run
WORKDIR /home/default-user
CMD jupyter lab --no-browser --ip="*" --port=8989 --allow-root welcome.ipynb
EXPOSE 8989