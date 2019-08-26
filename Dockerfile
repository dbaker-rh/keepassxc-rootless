FROM fedora:30
MAINTAINER Dave Baker <dbaker@redhat.com>

# xeyes is in here to help with debugging X access
# iputils (ping) to confirm/determine if we have networking enabled
# xauth to debug connectivity
RUN set -x && \
    dnf -y install --setopt=skip_missing_names_on_install=False \
           xauth iputils keepassxc xeyes && \
    dnf -y update -y && \
    dnf clean all && \
    rm -rf /var/cache/yum




# Expected to be a persistant volume to store kdbx files
VOLUME /root/data
WORKDIR /root/data

# keepass creates a ~/.config/keepassxc config file, as well as
# ~/.config/QtProject.conf for FileDialog prefs
RUN ln -sf /root/data/dot-config /root/.config


## Temporarily -- we run as "root" inside the container, which equates
## to your own userid outside the container.  To be fixed later.
## RUN useradd user
## USER user

CMD ["/usr/bin/keepassxc"]

