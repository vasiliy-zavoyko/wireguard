#!/usr/bin/env bash
echo "Entring Wireguard UI stat"
if [[ ! -f /etc/wireguard/wg0.conf ]]; then
    echo "Nothing to start" >&2
    exit 1
fi
if wg-quick up wg0; then
    echo -e "Wireguard started \n"
    sleep 1
    wg
    echo -e "\n"
    trap 'wg-quick down /etc/wireguard/wg0.conf' SIGTERM
    trap 'wg-quick down wg0' SIGTERM
    /app/restart.sh &
else
    echo "Failed to create tunnel" >&2
    exit 2
fi
/app/wireguard-ui &
wait $!
