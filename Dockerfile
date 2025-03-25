# syntax=docker/dockerfile:1
FROM ubuntu:22.04
EXPOSE 8080
EXPOSE 8529

# move into the home directory
RUN mkdir /home/default-user/
RUN mkdir /home/default-user/astro-otter
RUN mkdir /home/default-user/otterdb

# copy over the otter, otterdb, and examples
ADD otter /home/default-user/astro-otter

# install dependences
# Install dependencies and the GPG key
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    pkg-config

RUN pip install --upgrade pip
RUN pip install --upgrade setuptools setuptools_scm wheel pyArango

### Install API
# working directory for installs
WORKDIR /home/default-user/astro-otter/
RUN pip install --no-cache-dir $(pwd)

### Start the website server
WORKDIR /home/default-user/
RUN git clone https://github.com/astro-otter/otter-web.git
WORKDIR /home/default-user/otter-web
RUN pip install --no-cache-dir $(pwd)

# deal with user stuff
RUN groupadd -g 1001 otteruser && \
    useradd -u 1001 -g otteruser -s /bin/sh -m otteruser
RUN chown -R otteruser:otteruser /home/
USER otteruser

# when started run:
CMD python3 start.py