#!/bin/bash

PARENT_NAME="$(basename $(dirname $(realpath $0)))"
if [ $PARENT_NAME != "modules" ]; then
    exit 0
fi

sed -i "s/# deb-src/deb-src/g" /etc/apt/sources.list
apt-get update

yes | unminimize - 

apt-get install -y --no-install-recommends \
    curl git nano man wget vim unzip \
    build-essential supervisor iptables
