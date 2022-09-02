#!/bin/bash

PARENT_NAME="$(basename $(dirname $(realpath $0)))"
if [ $PARENT_NAME != "modules" ]; then
    #sed '/eval "$(starship init bash)/d' /root/.bashrc > /root/.bashrc
    sh -c 'rm "$(command -v 'starship')"'
    
    exit 0
fi

curl -sS https://starship.rs/install.sh | sh -s -- -y
#echo 'eval "$(starship init bash)"' >> /root/.bashrc


