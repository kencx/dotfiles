#!/bin/bash

set -eu

DISK=/dev/sda1
MOUNT_POINT=$1

mount -v $DISK "$MOUNT_POINT"

# wget https://raw.githubusercontent.com/rubo77/rsync-homedir-excludes/master/rsync-homedir-excludes.txt -O /var/tmp/ignorelist

SECONDS=0
rsync -a --delete \
    --exclude='syncthing/*' \
    --exclude='.cache/*' \
    --exclude='tmp/*' \
    /home/kenc "$MOUNT_POINT"
echo "rsync to $MOUNT_POINT completed in ${SECONDS}s"

umount -v "$MOUNT_POINT"
