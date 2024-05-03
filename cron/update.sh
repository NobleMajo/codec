#!/usr/bin/env bash

echo "[CODEC_CLI]: Crontask Update-All"
echo "AT: $2"
echo "--------------------------------"

sudo -u "$1" -s bash -c 'codeccli build -s; codeccli updateall -f'
