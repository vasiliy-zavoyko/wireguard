#!/usr/bin/env bash
if [[ ! -d /sys/class/net/wg0 ]]; then
    exit 1
fi
if [[ "$(cat /sys/class//net/wg0/carrier)" -eq 1 ]]; then
    exit 0
fi
exit 1
