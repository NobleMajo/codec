#!/bin/bash

PARENT_NAME="$(basename $(dirname $(realpath $0)))"
if [ $PARENT_NAME != "modules" ]; then
    rm -rf "/usr/local/bin/cd."
    rm -rf "/usr/local/bin/cd.."
    rm -rf "/usr/local/bin/cd..."
    rm -rf "/usr/local/bin/cd...."
    rm -rf "/usr/local/bin/cd....."

    exit 0
fi

printf "\ncd ..\n" > "/usr/local/bin/cd."
printf "\ncd ../..\n" > "/usr/local/bin/cd.."
printf "\ncd ../../..\n" > "/usr/local/bin/cd..."
printf "\ncd ../../../..\n" > "/usr/local/bin/cd...."
printf "\ncd ../../../../..\n" > "/usr/local/bin/cd....."
