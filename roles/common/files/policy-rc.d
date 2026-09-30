#!/bin/sh
# Managed by centralesupelec.mydocker.common: defer docker restart
# invoke-rc.d passes a bare name, deb-systemd-invoke passes unit names.
case "$1" in
    docker|docker.service|docker.socket|containerd|containerd.service)
        exit 101
        ;;
esac
exit 0
