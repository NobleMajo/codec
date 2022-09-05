#!/bin/bash

source /etc/environment

# clear cache files
/etc/codec/cache.sh

# health check
/etc/codec/health.sh

apt-get update

# default vscode extensions
/etc/codec/extensions.sh

# run vscode server service
systemctl start vscode

# readme 
/etc/codec/readme.sh

# init module system
/etc/codec/modules.sh