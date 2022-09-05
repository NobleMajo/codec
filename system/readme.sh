#!/bin/bash

echo "[CODEC][README]: Create folder..."
rm -rf /codec/.codec/readme.md
if [ -f "/etc/codec/readme.md" ] ; then
    exit 0
fi 
if cmp -s "/etc/codec/readme.md" "/codec/.codec/readme.md"; then
    exit 0
fi

code /etc/codec/readme.md
