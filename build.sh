#!/bin/bash
set -e

# build the docker image and run it
if [[ -z "$(docker images -q astro-otter:latest 2> /dev/null)" ]]; then
    # remove the docker container
    sudo docker image rm -f astro-otter
fi

# then build it
sudo docker image build -v /var/run/docker.sock:/var/run/docker.sock --no-cache -t astro-otter .

# then run it interactively
./rn
