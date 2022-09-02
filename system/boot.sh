#!/bin/bash

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

# run vscode server service
systemctl start vscode