#!/bin/bash

systemctl start lxc-monitord.service
systemctl start lxc.service
systemctl start containerd.service
systemctl start docker.service
