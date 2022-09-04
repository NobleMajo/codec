#!/bin/bash

PARENT_NAME="$(basename $(dirname $(realpath $0)))"
if [ $PARENT_NAME != "modules" ]; then
    systemctl disable ssh
    systemctl stop ssh
    exit 0
fi

systemctl enable ssh
systemctl start ssh