#!/bin/bash

echo "CodecMain: clear /tmp"
rm -rf /tmp/*
rm -rf /var/run/docker.pid

echo "CodecMain: Refresh, repair and renew default .codec if not exist..."
mkdir -p /home/codec/ws/.codec
# get all file and folder names in the /home/codec/.codec/skel dir as array
FILES=($(ls /home/codec/.codec/skel))
# check if one of that files is missing in the /home/codec/ws/.codec dir and copy it
for FILE in "${FILES[@]}"; do
    if [ ! -d "/home/codec/ws/.codec/$FILE" ] && [ ! -f "/home/codec/ws/.codec/$FILE" ]; then
        echo "copy..."
        cp -r /home/codec/.codec/skel/$FILE /home/codec/ws/.codec/$FILE
    fi
done

echo "CodecMain: Save ports and link code-server settings..."
# if $PORT_RANGE is set
if [ ! -z "$PORT_RANGE" ]; then
   # split $PORT_RANGE into $START_PORT and $END_PORT
    START_PORT=$(echo $PORT_RANGE | cut -d'-' -f1)
    END_PORT=$(echo $PORT_RANGE | cut -d'-' -f2)
    # throw error is $START_PORT is not a number between 1 and 65535
    if ! [[ $START_PORT =~ ^[0-9]+$ ]] || [ $START_PORT -lt 1 ] || [ $START_PORT -gt 65535 ]; then
        echo "The \$START_PORT environment variable must be a number between 1 and 65535"
        exit 1
    fi
    # throw error is $END_PORT is not a number between $START_PORT and 65535
    if ! [[ $END_PORT =~ ^[0-9]+$ ]] || [ $END_PORT -lt $START_PORT ] || [ $END_PORT -gt 65535 ]; then
        echo "The \$END_PORT environment variable must be a number between \$START_PORT and 65535"
        exit 1
    fi

    echo -n "$START_PORT-$END_PORT" > /home/codec/ws/.codec/ports.txt
else
    echo -n "This container has no published ports." > /home/codec/ws/.codec/ports.txt
fi

mkdir -p /home/codec/ws/.codec/bin
echo -n "#!/bin/bash\n\ncd ..\n" >> "/home/codec/.codec/bin/cd."
echo -n "#!/bin/bash\n\ncd ../..\n" >> "/home/codec/.codec/bin/cd.."
echo -n "#!/bin/bash\n\ncd ../../..\n" >> "/home/codec/.codec/bin/cd..."
echo -n "#!/bin/bash\n\ncd ../../../..\n" >> "/home/codec/.codec/bin/cd...."
chmod -R +x /home/codec/.codec/bin
chmod -R +x /home/codec/ws/.codec/bin

mkdir -p /home/codec/.local/share
rm -rf /home/codec/.local/share/code-server
ln -s /home/codec/ws/.codec/vscode /home/codec/.local/share/code-server

mkdir -p /usr/lib/code-server/vendor/modules/code-oss-dev
rm -rf /usr/lib/code-server/vendor/modules/code-oss-dev/product.json
ln -s /home/codec/ws/.codec/code-product.json /usr/lib/code-server/vendor/modules/code-oss-dev/product.json

rm -rf /home/codec/ws/.codec/logs
rm -rf /home/codec/ws/.codec/vscode/logs
rm -rf /home/codec/ws/.codec/vscode/coder-logs
rm -rf /home/codec/ws/.codec/vscode/User/Backups
rm -rf /home/codec/ws/.codec/vscode/User/workspaceStorage
mkdir -p /home/codec/ws/.codec/logs

echo -n "$@" > /home/codec/ws/.codec/arguments.txt

echo "CodecMain: Run boot script..."
source /etc/environment
source /home/codec/.codec/boot.sh > /home/codec/ws/.codec/logs/boot_$(date +"%m_%H_%d_%m_%Y").log

echo "CodecMain: Run code-server..."

nodemon \
    --delay 500ms \
    -w /home/codec/ws/.codec/code-server.yaml \
    -x "sudo -u codec /home/codec/.codec/code-server.sh"
