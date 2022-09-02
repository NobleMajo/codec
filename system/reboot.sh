#!/bin/bash

systemctl stop vscode@root

source /etc/environment
systemctl daemon-reload

systemctl start codec