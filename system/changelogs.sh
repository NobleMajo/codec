#!/usr/bin/env bash

echo "[CODEC][CHANGELOGS]: Init..."
touch /codec/.codec/changelogs.md

if [ -f "/codec/.codec/changelogs.md" ]; then
  if [ "$(cat /etc/codec/changelogs.md)" == "$(cat /codec/.codec/changelogs.md)" ]; then
    echo "[CODEC][CHANGELOGS]: No changes."
    exit 0
  fi
fi

rm -rf /codec/.codec/changelogs.md
cp /etc/codec/changelogs.md /codec/.codec/changelogs.md
cp /etc/codec/changelogs.md /codec/workspace/CODEC_CHANGELOGS.md