#!/bin/bash

ENV=

if [ -z "${ENV}" ]; then
    echo "ENV variable not set"
    exit 1
fi

[ $(whoami) = root ] || exec sudo su -c $0 root

rbd --name client.mydocker-${ENV} ls mydocker-${ENV} | grep -Ev "test|volume" | grep -Ev "[0-9]+\-{{ backy2_egrep_exclude_courses }}$" | xargs -I {} /home/ubuntu/backy2/backup-volume.sh mydocker-${ENV} {} client.mydocker-${ENV}
for version in $(backy2 --machine-output ls --expired --fields uid); do backy2 rm $version; done
backy2 cleanup
