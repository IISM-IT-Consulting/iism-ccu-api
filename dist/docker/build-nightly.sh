#!/bin/sh
# used to build a "nightly" image from the latest source code at IISM-IT-Consulting/iism-ccu-api which might not be a release yet
#
# TODO: multi-arch  
# export BUILD_VERSION=$(curl -Ls https://api.github.com/repos/IISM-IT-Consulting/iism-ccu-api/releases/latest | grep -o '"tag_name": "[^"]*' | grep -o '[^"]*$')
export BUILD_VERSION=$(curl -Ls https://raw.githubusercontent.com/IISM-IT-Consulting/iism-ccu-api/master/build/main.go | grep -o 'appVersion = "[^"]*' | grep -o '[^"]*$')
echo "Version"
echo $BUILD_VERSION
echo "-------------------------"
docker build --rm --no-cache \
    --build-arg BUILD_VERSION="${BUILD_VERSION}" \
    --build-arg BUILD_DATE="$(date +"%Y-%m-%dT%H:%M:%SZ")" \
    --build-arg BUILD_VERSION_NIGHTLY="${BUILD_VERSION}-$(date +"%Y-%m-%d")" \
    --tag iism-ccu-api:${BUILD_VERSION}_nightly \
    -f Dockerfile.nightly .
