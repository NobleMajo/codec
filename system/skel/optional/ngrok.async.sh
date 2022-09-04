#!/bin/bash

PARENT_NAME="$(basename $(dirname $(realpath $0)))"
if [ $PARENT_NAME != "modules" ]; then
    rm -rf /usr/local/bin/ngrok*
    exit 0
fi

tar xvzf ~/Downloads/ngrok-v3-stable-linux-amd64.tgz -C /usr/local/bin