#!/bin/bash

echo "[CODEC][README]: Init..."
rm -rf /codec/.codec/readme.md

if [ -f "/codec/.codec/readme.md" ]; then
  if [ "$(cat /etc/codec/readme.md)" == "$(cat /codec/.codec/readme.md)" ]; then
    exit 0
  fi
fi

cp /etc/codec/readme.md /codec/.codec/readme.md

echo "[CODEC][README]: Open readme file!"
code /etc/codec/readme.md > /dev/null 2>&1
