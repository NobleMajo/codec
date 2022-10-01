#!/bin/bash

# set domain
nextcloud.occ config:system:set trusted_domains 1 "--value=$CLOUD_HOST"

# setup admin user
nextcloud.manual-install codec "$CLOUD_PASSWORD"

# generate self signed certificat
nextcloud.enable-https self-signed