#!/usr/bin/env bash
while ! inotifywait -e modify /etc/wireguard/wg0.conf; do
    echo "/etc/wireguard/wg0.conf changed"
    wg-quick down wg0
    wg-quick up wg0
    echo -e "\n"
    sleep 1
    wg
    echo -e "\n"
done
