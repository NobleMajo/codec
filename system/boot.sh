#!/bin/bash

apt-get update
apt-get full-upgrade -y
apt-get autoremove -y

source /etc/environment

# clear cache files
/etc/codec/cache.sh

# health check
/etc/codec/health.sh
echo "$CODEC_PORTS" > /codec/.codec/ports.txt

# default vscode extensions
/etc/codec/extensions.sh

# init module system
/etc/codec/modules.sh

apt-get clean
apt-get autoclean
rm -rf /var/lib/apt/lists/*
rm -rf /var/cache/apk/*
rm -rf /root/.cache
rm -rf /root/.npm
rm -rf /tmp/*
apt-get update

# run vscode server service
systemctl start vscode