#!/usr/bin/env bash
set -euo pipefail

# LanguageTool server run script using Podman

# meyayl/docker-languagetool	meyay/languagetool
IMAGE="docker.io/meyay/languagetool:latest"
# Erikvl87/docker-languagetool	erikvl87/languagetool
IMAGE="docker.io/erikvl87/languagetool:latest"
# silvio/docker-languagetool	silviof/docker-languagetool
IMAGE="docker.io/silviof/docker-languagetool:latest"
CONTAINER_NAME="languagetool"
HOST_PORT=8010
CONTAINER_PORT=8010

# Stop and remove existing container if it exists
if podman ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "Removing existing container: ${CONTAINER_NAME}"
    podman rm -f "${CONTAINER_NAME}"
fi

echo "Starting LanguageTool container..."
podman run --detach \
    --name "${CONTAINER_NAME}" \
    --publish "${HOST_PORT}:${CONTAINER_PORT}" \
    --env Java_Xms=512m \
    --env Java_Xmx=2g \
    --restart unless-stopped \
    "${IMAGE}"

echo "LanguageTool is starting up..."
echo "It will be available at http://localhost:${HOST_PORT}"

# Optional: follow logs
podman logs -f "${CONTAINER_NAME}"
