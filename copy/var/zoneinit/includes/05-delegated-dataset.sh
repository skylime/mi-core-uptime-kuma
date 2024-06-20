#!/usr/bin/env bash

if DDS=$(/opt/core/bin/dds); then
    zfs create "${DDS}/kuma" || true
    zfs set mountpoint=/var/db/kuma "${DDS}/kuma"
else
    mkdir -p /var/db/kuma
fi

chown -R kuma:kuma /var/db/kuma || true
