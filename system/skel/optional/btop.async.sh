#!/bin/bash

echo " ### Download btop package..."
wget -qO /tmp/btop.tbz.tmp https://github.com/aristocratos/btop/releases/latest/download/btop-x86_64-linux-musl.tbz

echo " ### Extract btop bin..."
sudo tar xf /tmp/btop.tbz.tmp -C /usr/local bin/btop

echo " ### Clean btop archive..."
rm -rf /tmp/btop.tbz.tmp

echo " ### Finished!"