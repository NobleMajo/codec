#!/bin/bash

if [ -z "$SSH_SERVER_PORT" ]; then
    SSH_SERVER_PORT="$CODEC_START_PORT"
fi

sed '/Port /d' /etc/ssh/sshd_config > /etc/ssh/sshd_config
echo "Port $SSH_SERVER_PORT" >> /etc/ssh/sshd_config
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

systemctl enable sshd
systemctl start sshd