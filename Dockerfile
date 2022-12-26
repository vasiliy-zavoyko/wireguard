FROM ubuntu:latest
WORKDIR /app
COPY startup.sh startup.sh
COPY healthcheck.sh healthcheck.sh
COPY restart.sh restart.sh
RUN \
    apt-get update; \
    apt-get install -y --no-install-recommends iptables iproute2 iputils-ping openresolv wireguard-tools inotify-tools wget ca-certificates; \
    wget https://github.com/ngoduykhanh/wireguard-ui/releases/download/v0.4.0/wireguard-ui-v0.4.0-linux-amd64.tar.gz; \
    apt-get remove -y wget; \
    tar -xvf ./wireguard-ui-v0.4.0-linux-amd64.tar.gz; \
    chmod +x wireguard-ui; \
    chmod +x startup.sh; \
    chmod +x healthcheck.sh; \
    chmod +x restart.sh; \
    rm -f ./wireguard-ui-v0.4.0-linux-amd64.tar.gz; \
    apt-get autoremove -y; \
    apt-get clean -y; \
    rm -rf /var/lib/apt/lists/*
ENV PATH="$PATH:/app"
ENTRYPOINT startup.sh
HEALTHCHECK --interval=35s --timeout=4s --start-period=5s CMD healthcheck.sh
