#!/bin/bash

echo "CodecMain: Execute code-server..."

code-server \
    --port 8080 \
    --host 0.0.0.0 \
    /home/codec/ws/.codec/default.code-workspace

#    --cert /home/code/ws/.codec/certs/cert.crt \
#    --cert-key /home/code/ws/.codec/certs/cert.key \
#--proxy-domain coreunit.net/majo/ \
#--disable-ssh \
