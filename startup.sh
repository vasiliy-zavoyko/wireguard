#!/usr/bin/env bash
echo "Entering Wireguard stat"
if [[ ! -f /etc/wireguard/wg0.conf ]]; then
    echo "Nothing to start" >&2
    exit 1
fi
if wg-quick up wg0; then
    echo -e "Wireguard started \n"
    sleep 1
    wg
    echo -e "\n"
    /app/restart.sh &
else
    echo "Failed to create tunnel" >&2
    exit 2
fi
