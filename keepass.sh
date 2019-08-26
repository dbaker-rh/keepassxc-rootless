#!/bin/sh

# KeepassXC inside rootless podman container
#   https://github.com/dbaker-rh/keepassxc-rootless


## Setting "none" prohibits the program from making any network
## connections (which may be a good thing).  Setting it to "net"
## lets you - e.g. - download favicons and other custom icons.

NETWORK=none
# NETWORK=net

podman run --rm \
     --net=$NETWORK \
     -e DISPLAY -e XAUTHORITY \
     --volume="$XAUTHORITY:$XAUTHORITY" \
     --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
     --volume="$HOME/.private:/root/data" \
     --device=/dev/dri \
     --privileged \
     --name keepassxc \
           keepassxc


