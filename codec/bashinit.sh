#!/bin/bash

echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -password
source /etc/environment
source /home/codec/ws/.codec/bashinit.sh