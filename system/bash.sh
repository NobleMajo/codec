#!/bin/bash 

source /etc/environment

codec -w

MODS_PATH="/codec/.codec/enabled-mods"
BASH_MOD_PATHS=("$(find $MODS_PATH -name "*.bash.sh")")

for BASH_MOD_PATH in $BASH_MOD_PATHS; do
    source $BASH_MOD_PATH
done