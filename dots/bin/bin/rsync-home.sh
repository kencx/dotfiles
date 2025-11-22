#!/usr/bin/env bash

set -eu

DISK=/dev/sda1
MOUNT_POINT=$1

mount -v $DISK "$MOUNT_POINT"

SECONDS=0
rsync -a --delete \
    --exclude-from=/home/kenc/dotfiles/etc/rsync-homedir-excludes.txt \
    --exclude='syncthing/sync/*' \
    --exclude='.cache/*' \
    --exclude='.env/*' \
    --exclude='.ghcup' \
    --exclude='.cabal' \
    --exclude='.pyenv' \
    --exclude='.ansible' \
    --exclude='tmp' \
    --exclude='Downloads/*' \
    --exclude='dev/compose-stacks/qbittorrent/torrents/*' \
    "/home/kenc" "$MOUNT_POINT"

echo "rsync to $MOUNT_POINT completed in ${SECONDS}s"

umount -v "$MOUNT_POINT"
