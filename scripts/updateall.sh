#!/usr/bin/env bash

export CURRENT_DIR=$(dirname $(realpath $0))
source $CURRENT_DIR/vars.sh

FLAG_NAME="--scratch"
FLAG_SHORTNAME="-s"
if [ "$1" == "$FLAG_NAME" ] ||  [ "$1" == "$FLAG_SHORTNAME" ]  ||
    [ "$2" == "$FLAG_NAME" ] ||  [ "$2" == "$FLAG_SHORTNAME" ]  ||
    [ "$3" == "$FLAG_NAME" ] ||  [ "$3" == "$FLAG_SHORTNAME" ]  ||
    [ "$4" == "$FLAG_NAME" ] || [ "$5" == "$FLAG_NAME" ] ||
    [ "$6" == "$FLAG_NAME" ] || [ "$7" == "$FLAG_NAME" ] ||
    [ "$4" == "$FLAG_SHORTNAME" ] || [ "$5" == "$FLAG_SHORTNAME" ] ||
    [ "$6" == "$FLAG_SHORTNAME" ] || [ "$7" == "$FLAG_SHORTNAME" ]; then
    $CURRENT_DIR/build.sh -s > /dev/null 2>&1 &
    BUILD_PID=$!
    echo "[CODEC_CLI][UPDATEALL]: Build image in background from scratch!"
    echo "This can take some minutes!"
    echo "Background process id: '$BUILD_PID'"
else
    $CURRENT_DIR/build.sh > /dev/null 2>&1 &
    BUILD_PID=$!
    echo "[CODEC_CLI][UPDATEALL]: Build image in background."
    echo "Background process id: '$BUILD_PID'"
fi

echo "[CODEC_CLI][UPDATEALL]: Load codec container user list..."
USER_LIST=$(ls -AQ $CODEC_USER_DATA)

USER_LIST=${USER_LIST::-1}
USER_ARR=()
for USER_FOLDER in ${USER_LIST[@]}; do
    if [ $USER_FOLDER == '".codec"' ]; then
        continue
    fi
    USER_ARR+=($(echo -n "${USER_FOLDER:1:-1}"))
done

if [ "${#USER_ARR[@]}" == "0" ]; then
    echo "[CODEC_CLI][UPDATEALL]: No codec user exists!"
    exit 1
fi

echo ""
echo "[CODEC_CLI][UPDATEALL]: "
echo "##### UPDATE ALL #####"
echo "# Following users will be re/started:"
for USER_NAME in ${USER_ARR[@]}; do
    echo "# - '$USER_NAME'"
done

FLAG_NAME="--force"
FLAG_SHORTNAME="-f"
if [ "$1" == "$FLAG_NAME" ] ||  [ "$1" == "$FLAG_SHORTNAME" ]  ||
    [ "$2" == "$FLAG_NAME" ] ||  [ "$2" == "$FLAG_SHORTNAME" ]  ||
    [ "$3" == "$FLAG_NAME" ] ||  [ "$3" == "$FLAG_SHORTNAME" ]  ||
    [ "$4" == "$FLAG_NAME" ] || [ "$5" == "$FLAG_NAME" ] ||
    [ "$6" == "$FLAG_NAME" ] || [ "$7" == "$FLAG_NAME" ] ||
    [ "$4" == "$FLAG_SHORTNAME" ] || [ "$5" == "$FLAG_SHORTNAME" ] ||
    [ "$6" == "$FLAG_SHORTNAME" ] || [ "$7" == "$FLAG_SHORTNAME" ]; then
    echo "[CODEC_CLI][UPDATEALL]: Force update all containers!"
else
    echo "# Enter 'y' to start the '${#USER_ARR[@]}' codec user containers."
    echo "# [CTRL] + [C] to abort!"
    read INPUT_VALUE
    if [ "$INPUT_VALUE" != "y" ]; then
        echo "Abort because input was not 'y'!"
        exit 1
    fi
fi

echo "[CODEC_CLI][UPDATEALL]: Wait for image building..."
wait $BUILD_PID
echo "[CODEC_CLI][UPDATEALL]: Image ready!"

echo "[CODEC_CLI][UPDATEALL]: Start user container..."
for USER_NAME in ${USER_ARR[@]}; do
    echo "##### ##### ##### ##### ##### ##### #####"
    echo "                    Next user: $USER_NAME"
    $CURRENT_DIR/start.sh "$USER_NAME" -f
done
echo "##### ##### ##### ##### ##### ##### #####"

echo "[CODEC_CLI][UPDATEALL]: All containers started!"

echo "[CODEC_CLI][UPDATEALL]: Clear unused docker resources..."
docker system prune -f --volumes --all

echo "[CODEC_CLI][UPDATEALL]: Finished!"
