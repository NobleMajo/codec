#!/bin/bash

CURRENT_DIR=$(dirname $(realpath $0))

$CURRENT_DIR/uncron.sh

if [ -z "$CODEC_USER_DATA" ]; then
    CODEC_USER_DATA="/var/lib/codec"
fi

sudo crontab -l > /tmp/codec-cron
sudo echo "50 4 * * * \$(echo \"----- ----- -----\"; date +\"%Y.%m.%d_%H:%M\"; echo \"----- ----- -----\"; codeccli updateall -s -f) >> $CODEC_USER_DATA/.codec/\$(date +\"%Y_%m_%d_%H_%M\").log" >> /tmp/codec-cron
sudo crontab /tmp/codec-cron
sudo rm -rf /tmp/codec-cron
