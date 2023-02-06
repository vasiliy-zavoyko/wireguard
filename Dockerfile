FROM ubuntu:latest
WORKDIR /app
COPY startup.sh startup.sh
COPY healthcheck.sh healthcheck.sh
COPY restart.sh restart.sh
RUN \
    apt-get update; \
    apt-get install -y --no-install-recommends iptables iproute2 iputils-ping openresolv wireguard-tools inotify-tools nano dumb-init; \
    chmod +x startup.sh; \
    chmod +x healthcheck.sh; \
    chmod +x restart.sh; \
    apt-get autoremove -y; \
    apt-get clean -y; \
    rm -rf /var/lib/apt/lists/*
ENV PATH="$PATH:/app"
ENTRYPOINT ["/usr/bin/dumb-init", "startup.sh"]
HEALTHCHECK --interval=45s --timeout=4s --start-period=5s CMD healthcheck.sh
