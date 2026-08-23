#!/usr/bin/env bash
set -euo pipefail

# LanguageTool server run script using Podman

IMAGE="erikvl87/languagetool:latest"
CONTAINER_NAME="languagetool"
HOST_PORT=8010
CONTAINER_PORT=8010

# Stop and remove existing container if it exists
if podman ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "Removing existing container: ${CONTAINER_NAME}"
    podman rm -f "${CONTAINER_NAME}"
fi

echo "Starting LanguageTool container..."
podman run -d \
    --name "${CONTAINER_NAME}" \
    -p "${HOST_PORT}:${CONTAINER_PORT}" \
    -e Java_Xms=512m \
    -e Java_Xmx=2g \
    --restart unless-stopped \
    "${IMAGE}"

echo "LanguageTool is starting up..."
echo "It will be available at http://localhost:${HOST_PORT}"

# Optional: follow logs
podman logs -f "${CONTAINER_NAME}"
