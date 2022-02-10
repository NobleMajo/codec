#!/bin/bash
#
# executes on container start
#

echo "CodecInit: Inside skeleton \"init.sh\"..."
# setup your container and do so some other stuff...

echo "CodecInit: Set id_rsa"
eval "$(ssh-agent -s)" >/dev/null 2>&1
ssh-add ~/.ssh/id_rsa >/dev/null 2>&1

#echo "CodecInit: Set default password..."
# by default: changeme
#/home/codec/src/.codec/bin/codepr 057ba03d6c44104863dc7361fe4578965d1887360f90a0895882e58a6248fc86

echo "CodecInit: Set max file watcher count"
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

echo "CodecInit: Container READY!"