#!/bin/sh
# used to build a stable image from the latest release from IISM-IT-Consulting/iism-ccu-api
#
export BUILD_VERSION=$(curl -Ls https://api.github.com/repos/IISM-IT-Consulting/iism-ccu-api/releases/latest | grep -oP '"tag_name": "v\K(.*)(?=")')
docker build --rm --no-cache \
    --build-arg BUILD_VERSION="${BUILD_VERSION}" \
    --build-arg BUILD_DATE="$(date +"%Y-%m-%dT%H:%M:%SZ")" \
    --tag iism-ccu-api:latest --tag iism-ccu-api:${BUILD_VERSION} .
