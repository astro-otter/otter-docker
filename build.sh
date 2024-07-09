#!/bin/bash
# build the docker image and run it
set -e

if [[ -z "$(docker images -q astro-otter:latest 2> /dev/null)" ]]; then

    # if the docker container exists and the repo has no local changes we can leave it
    if [[ ! `git status --porcelain` ]]; then
        echo "No local git changes so no need to rebuild the docker image!"
        exit 1
    fi
    
    # remove the docker container
    sudo docker image rm -f astro-otter
fi

# then build it
sudo docker image build -t astro-otter .

# then run it
if [[ -z $1 ]]; then
    # run interactively if anything is passed to this file
    sudo docker run -it astro-otter
else
    sudo docker run astro-otter
fi

