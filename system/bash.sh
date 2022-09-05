#!/bin/bash 

source /etc/environment

MODULES_PATH="/codec/.codec/modules"
BASH_MODULE_PATHS=("$(find $MODULES_PATH -name "*.bash.sh")")

for BASH_MODULE_PATH in $BASH_MODULE_PATHS; do
    source $BASH_MODULE_PATH
    {
        source $BASH_MODULE_PATH &&
    } || { 
        echo "[CODEC][MODULE][ERROR]: Can't load bash module at '$BASH_MODULE_PATH'!"
    }
done