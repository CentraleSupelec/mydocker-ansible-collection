#!/bin/sh
# Managed by centralesupelec.mydocker.common: defer docker restart
# invoke-rc.d passes a bare name, deb-systemd-invoke passes unit names.
# invoke-rc.d may pass --quiet before the name.
while [ "${1#--}" != "$1" ]; do
    shift
done
case "$1" in
    docker|docker.service|docker.socket|containerd|containerd.service|containerd.socket)
        exit 101
        ;;
esac
exit 0
