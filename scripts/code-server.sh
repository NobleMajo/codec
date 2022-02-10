#!/bin/bash

echo "CodecMain: Execute code-server..."

code-server \
    --verbose \
    --disable-update-check \
    --disable-telemetry \
    --port 33333 \
    --host 0.0.0.0 \
    --cert /home/code/ws/.codec/certs/cert.crt \
    --cert-key /home/code/ws/.codec/certs/cert.key \
    --user-data-dir /home/codec/ws/.codec/userdata \
    --extensions-dir /home/codec/ws/.codec/extensions \
    /home/codec/ws/.codec/default.code-workspace

#--proxy-domain coreunit.net/majo/ \
#--disable-ssh \