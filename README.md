# otter-docker
Code to setup and install the otter docker container.

# Installation
## Install Docker
* Linux: https://docs.docker.com/desktop/install/linux-install/
* macOS: https://docs.docker.com/desktop/install/mac-install/
* Windows: https://docs.docker.com/desktop/install/windows-install/

## Build and Run the Docker Container
### Linux/macOS
Make sure git is installed and then in a terminal run
```
git clone https://github.com/astro-otter/otter-docker.git
```

You should just be able to run the following commands
```
cd otter-docket
./build.sh
```

### Windows
If you use wsl2 (I think that's the only way to run docker on windows from the
command line) just go and follow the instructions for Linux/macOS and it should
just work! Please raise an issue if it doesn't (I can't test this).