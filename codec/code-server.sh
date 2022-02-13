#!/bin/bash

echo "CodecMain: copy new config..."
mkdir -p /home/codec/.config/code-server
rm -rf /home/codec/.config/code-server/config.yaml
cp /home/codec/ws/.codec/code-server.yaml /home/codec/.config/code-server/config.yaml

export EXTENSIONS_GALLERY='{ "serviceUrl": "https://marketplace.visualstudio.com/_apis/public/gallery", "cacheUrl": "https://vscode.blob.core.windows.net/gallery/index", "itemUrl": "https://marketplace.visualstudio.com/items", "controlUrl": "", "recommendationsUrl": "" }'

echo "CodecMain: Execute code-server..."

code-server \
    --port 8080 \
    --host 0.0.0.0 \
    /home/codec/ws/.codec/default.code-workspace

#    --cert /home/code/ws/.codec/certs/cert.crt \
#    --cert-key /home/code/ws/.codec/certs/cert.key \
#--proxy-domain coreunit.net/majo/ \
#--disable-ssh \
