# Please don't use this filke directly but
# build the image with Shellscript "./build-release.sh"

FROM alpine

ARG BUILD_DATE
ARG BUILD_VERSION

LABEL org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.version=$BUILD_VERSION \
      org.opencontainers.image.title="IISM-CCU-Api" \
      org.opencontainers.image.description="REST/MQTT-Server for the HomeMatic CCU" \
      org.opencontainers.image.vendor="IISM-CCU-Api OpenSource Project" \
      org.opencontainers.image.authors="IISM <kontakt@iism.de>" \
      org.opencontainers.image.licenses="GPL-3.0 License" \
      org.opencontainers.image.url="https://github.com/IISM-IT-Consulting/iism-ccu-api" \
      org.opencontainers.image.documentation="https://github.com/IISM-IT-Consulting/iism-ccu-api/blob/master/README.md"

# Set work directory
WORKDIR /app

# Get the latest relase from github and extract it locally
RUN wget -q -O - "https://github.com/IISM-IT-Consulting/iism-ccu-api/releases/download/v${BUILD_VERSION}/iism-ccu-api-linux-${BUILD_VERSION}.tar.gz" | tar -xvzC . && \
    mkdir -p /app/conf /app/cert /data && \
    adduser -h /app -D -H iism-ccu-api -u 1000 -s /sbin/nologin && \
    chown -R iism-ccu-api:iism-ccu-api /data && chmod -R g+rwX /data && \
    chown -R iism-ccu-api:iism-ccu-api /app && chmod -R g+rwX /app

USER iism-ccu-api

# MQTT, MQTT TLS, IISM-CCU-Api VEAM/UI, IISM-CCU-Api VEAM/UI TLS, CUxD
EXPOSE 1883 8883 2121 2122 2123

# Add a healthcheck (default every 30 secs)
HEALTHCHECK --interval=30s --timeout=5s --start-period=40s --retries=3 \
    CMD wget --spider -S -q http://localhost:2121/ui/ 2>&1 | head -1 || exit 1

# workaround to save certificates and make config readable
WORKDIR /app
# Start it up with full path

ENTRYPOINT [ "/app/iism-ccu-api","-config","/app/conf/iism-ccu-api.cfg" ]