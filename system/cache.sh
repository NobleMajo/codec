#!/usr/bin/env bash

echo "[CODEC][CACHE]: Clear vscode cache files..."
rm -rf /codec/mounts/vscode/User/caches
rm -rf /codec/mounts/vscode/logs
rm -rf /codec/mounts/vscode/CachedExtensions
rm -rf /codec/mounts/vscode/coder-logs
rm -rf /codec/mounts/vscode/User/customBuiltinExtensionsCache.json
rm -rf /tmp/*

