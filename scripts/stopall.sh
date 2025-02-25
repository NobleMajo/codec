#!/usr/bin/env bash

export CURRENT_DIR=$(dirname $(realpath $0))
source $CURRENT_DIR/vars.sh

echo "[CODEC_CLI][STOPALL]: Load codec container user list..."
USER_LIST=$(ls -AQ $CODEC_USER_DATA)

USER_LIST=${USER_LIST::-1}
USER_ARR=()
for USER_FOLDER in ${USER_LIST[@]}; do
    if [ $USER_FOLDER == '".codec"' ]; then
        continue
    fi
    USER_ARR+=($(echo -n "${USER_FOLDER:1:-1}"))
done

if ["${#USER_ARR[@]}" == "0"]; then
    echo "[CODEC_CLI][UPDATEALL]: No codec user exists!"
    exit 1
fi

echo ""
echo "[CODEC_CLI][STOPALL]: "
echo "##### STOP ALL #####"
echo "# Stop following users?"
for USER_NAME in ${USER_ARR[@]}; do
    echo "# - '$USER_NAME'"
done

echo "# Enter 'y' to start the '$1' codec user container."
echo "# [CTRL] + [C] to abort!"
read INPUT_VALUE
if [ "$INPUT_VALUE" != "y" ]; then
    echo "Abort because input was not 'y'!"
    exit 1
fi 

echo "[CODEC_CLI][STOPALL]: Stop user container..."
for USER_NAME in ${USER_ARR[@]}; do
    echo "##### ##### ##### ##### ##### ##### #####"
    echo "                    Next user: $USER_NAME"
    $CURRENT_DIR/close.sh $USER_NAME
done
echo "##### ##### ##### ##### ##### ##### #####"

echo "[CODEC_CLI][STOPALL]: All user contaienrs stopped!"
