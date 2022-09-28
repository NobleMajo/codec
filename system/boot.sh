#!/bin/bash

source /etc/environment

# clear cache files
/etc/codec/cache.sh

# health check
/etc/codec/health.sh

apt-get update

# default vscode extensions
/etc/codec/extensions.sh

# init module system
/etc/codec/modules.sh

# run vscode server service
echo "[CODEC][VSCODE]: Start vscode service..."
systemctl start vscode

# init async modules
/etc/codec/modules_async.sh

echo "[CODEC][VSCODE]: Done!"