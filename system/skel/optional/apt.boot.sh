#!/bin/bash

PARENT_NAME="$(basename $(dirname $(realpath $0)))"
echo "test: -$PARENT_NAME-"
if [ $PARENT_NAME != "modules" ]; then
    exit 0
fi

apt-get update
apt-get full-upgrade -y
apt-get autoremove -y
