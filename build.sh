#!/bin/bash
set -e

# create the otter container network if it doesn't exist
docker network create otter-network || true

# then build and start the arango db
if [[ -z "$(docker images -q otterdb:latest 2> /dev/null)" ]]; then
    # remove the docker container
    sudo docker image rm -f otterdb
fi

cd otterdb
./clean.sh
./build.sh
cd ..

# build the docker image and run it
if [[ -z "$(docker images -q astro-otter:latest 2> /dev/null)" ]]; then
    # remove the docker container
    sudo docker image rm -f astro-otter
fi

# then build it
sudo docker image build -t astro-otter .

# then run it interactively
./rn
