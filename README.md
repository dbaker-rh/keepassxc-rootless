# KeePassXC, rootless, on RHEL8

## Prep packages

To run rootless on RHEL8 you will probably need packages from the nightly
repos for at least a while longer.

   sudo dnf --enablerepo=*nightly* update \
        runc podman podman-docker slirp4netns \
        containernetworking-plugins container-selinux

NOTE: Use "dnf list | grep nightly" to look for other packages installed
via nightly repos which may also need updating.


## Building

   podman build . -t keepassxc


## Running

I like to configure settings to turn on the taskbar icon.

   ./keepass.sh


## X11 / Wayland / etc

Contrary to various things found online, running the graphical app inside
the container is not as complicated as it appears at first.

We pass $DISPLAY (as is) and also /tmp/.X11-unix through to the container,
which lets the application know where it will try to display the interface.

We pass $XAUTHORITY (as is) and also the file referred to, which provides
the tokens required to open the display.  As an alternative, we COULD use
"xhost -SI:localuser:$(id -un)" although this requires additional setup
steps which passing XAUTHORITY avoids.


## Data files

I put my data files in $HOME/.private and pass this to the container as
/root/data.  Also inside this directory is a nominal space for .config to
capture the keepassxc configuration between runs.


## As root??

Temporarily, we run as root inside the container, appearing as effectively
my regular userid outside of it.

TODO: Don't run as root.


