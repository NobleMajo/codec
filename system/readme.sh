#!/bin/bash

echo "[CODEC][README]: Init..."
rm -rf /codec/.codec/readme.md

if [ -f "/codec/.codec/readme.md" ]; then
  if [ "$(cat /etc/codec/readme.md)" == "$(cat /codec/.codec/readme.md)" ]; then
    exit 0
  fi
fi

cp /etc/codec/readme.md /codec/.codec/readme.md

#todo repair readme
#echo "[CODEC][README]: Open readme file!"
#code /etc/codec/readme.md > /dev/null 2>&1

#Sep 25 02:40:00 ffbf60fe179d systemd[1]: codec.service: Main process exited, code=exited, status=1/FAILURE
#Sep 25 02:40:00 ffbf60fe179d systemd[1]: codec.service: Failed with result 'exit-code'.