# VAPOR web application testing

I got the container to build and use the NVIDIA GPU for OpenGL with the following command

`docker run --rm -it -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY -e XAUTHORITY -e NVIDIA_DRIVER_CAPABILITIES=all -
p 5000:5000 --runtime=nvidia -e ENV_NAME=vapor ncote/vapor-test`