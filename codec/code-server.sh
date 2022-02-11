#!/bin/bash

echo "CodecMain: copy new config..."
mkdir -p /home/codec/.config/code-server
rm -rf /home/codec/.config/code-server/config.yaml
cp /home/codec/ws/.codec/code-server.yaml /home/codec/.config/code-server/config.yaml

echo "CodecMain: Execute code-server..."

code-server \
    --port 8080 \
    --host 0.0.0.0 \
    /home/codec/ws/.codec/default.code-workspace

#    --cert /home/code/ws/.codec/certs/cert.crt \
#    --cert-key /home/code/ws/.codec/certs/cert.key \
#--proxy-domain coreunit.net/majo/ \
#--disable-ssh \
