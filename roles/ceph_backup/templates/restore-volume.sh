#!/bin/bash

set -e

if [ -z $1 ] ; then
        echo "Usage: $0 volume-name"
        exit 1
fi

[ $(whoami) = root ] || exec sudo su root -c "$0 $1"

backy2 fuse /mnt/backy2 &
BACKY2_PID=$!

trap "catch $BACKY2_PID" ERR EXIT SIGINT SIGTERM SIGHUP
catch() {
        trap - SIGINT
        kill $1
        kill -s SIGINT 0
}

sleep 2

backy2 --machine-output ls $1 --fields uid | sort | tail -n1 | xargs -I {} mount /mnt/backy2/by_version_uid/{}/data /mnt/restored

echo "Backup volume mounted on /mnt/restored"
echo "To unmount the volume, press CTRL+C"

while true; do read; done