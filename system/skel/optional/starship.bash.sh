#!/bin/bash

#echo "#/bin/bash" > /tmp/starship.sh
#echo "$(starship init bash)" >> /tmp/starship.sh
#chmod +x /tmp/starship.sh
#source /tmp/starship.sh

source <(/usr/local/bin/starship init bash --print-full-init)