#!/bin/bash

source /etc/environment

# clear cache files
/etc/codec/cache.sh

# health check
/etc/codec/health.sh

apt-get update

# default vscode extensions
/etc/codec/extensions.sh

# init mod system
/etc/codec/mods.sh

# run vscode server service
echo "[CODEC][VSCODE]: Start vscode service..."
systemctl start vscode

# init async mods
/etc/codec/mods_async.sh

echo "[CODEC][VSCODE]: Done!"