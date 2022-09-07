#!/bin/bash

echo "[CODEC][CHANGELOGS]: Init..."
rm -rf /codec/.codec/changelogs.md

if [ -f "/codec/.codec/changelogs.md" ] && [ "$(cat /etc/codec/changelogs.md)" == "$(cat /codec/.codec/changelogs.md)" ]; then
    echo "EXIT 222"
    exit 0
fi 

cp /etc/codec/changelogs.md /codec/.codec/changelogs.md

echo "[CODEC][CHANGELOGS]: Open changelogs file!"
code /etc/codec/changelogs.md > /dev/null 2>&1
