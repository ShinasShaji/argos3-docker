# ARGoS in Docker
[![GitHub](https://img.shields.io/badge/license-MIT-green)](https://github.com/tylerferrara/argos3-docker/blob/master/LICENSE)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/tjferrara/argos3/latest?logo=docker)

> Portable robot simulation environment, using [ARGoS](https://github.com/ilpincy/argos3). Built within docker containers & displayed via browser-based VNC (noVNC), ARGoS should now be accessable on **all platforms**.

## Usage
```bash
$ docker run -p 6080:80 -v /dev/shm:/dev/shm tjferrara/argos3:latest
```

Visit http://localhost:6080 on your browser of choice, to display the GUI.

![Argos in browser"](extras/argos-in-browser.png)
 ___

### [ Optional ] Customization 
```bash
$ docker run \
    -e USER=doro \                  # Create a new user
    -e PASSWORD=password \          # Password for new user
    -e RESOLUTION=1920x1080 \       # Resolution of VNC
    -e HTTP_PASSWORD=mypassword \   # Password for VNC
    -p 6080:80 -v /dev/shm:/dev/shm tjferrara/argos3:latest
```
These options are given by the base image `dorowu/ubuntu-desktop-lxde-vnc`.
For more customization information, visit https://hub.docker.com/r/dorowu/ubuntu-desktop-lxde-vnc.

## Build it yourself

To build and run the container:
```bash
$ git clone https://github.com/tylerferrara/argos3-docker.git argos3-docker
$ cd argos3-docker
$ docker-compose up --build
```
**NOTE:** This can take up to 15min to compile as it builds ARGoS from source.

### Additional Notes

The following environment variables were added to the container docker compose file due to a Qt platform plugin error.
```bash
export QT_QPA_PLATFORM=xcb
export DISPLAY=:1
```

## Running example experiments

To run the example experiments, you need to start the container (ensure that the name of the container is `argos3-docker-sim-1` using `sudo docker ps` or `sudo docker stats`) and then run the following command:
```bash
$ sudo docker exec -it argos3-docker-sim-1 /bin/bash
```

This will open a bash shell into the container in `/setup`. From there, you can run the following command to run the example experiments:
```bash
$ cd argos3-examples/
$ argos3 -c experiments/diffusion_10.argos
```

This will run the `diffusion_10.argos` experiment. You can find more example experiments in the `argos3-examples/experiments/` directory.

Visit http://localhost:6080/vnc.html to view the simulation window.
