#!/bin/bash

PARENT_NAME="$(basename $(dirname $(realpath $0)))"
if [ $PARENT_NAME != "modules" ]; then
    systemctl stop lxc-monitord.service
    systemctl stop lxc.service
    systemctl stop containerd.service
    systemctl stop docker.service

    exit 0
fi

systemctl start lxc-monitord.service
systemctl start lxc.service
systemctl start containerd.service
systemctl start docker.service
