#!/bin/bash
# build the docker image and run it
set -e

if [[ -z "$(docker images -q astro-otter:latest 2> /dev/null)" ]]; then
    # remove the docker container
    sudo docker image rm -f astro-otter
fi

# then build it
sudo docker image build -t astro-otter .

# then run it interactively
./rn
