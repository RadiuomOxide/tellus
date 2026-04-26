#!/usr/bin/env bash
set -e

IMAGE="tellus-dev"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Rebuild if --build flag passed or image doesn't exist
if [[ "$1" == "--build" ]] || ! docker image inspect "$IMAGE" &>/dev/null; then
    echo "Building $IMAGE..."
    docker build -t "$IMAGE" "$SCRIPT_DIR"
fi

echo ""
echo "  Project : $SCRIPT_DIR"
echo "  Image   : $IMAGE"
echo "  Auth    : using host ~/.claude (no login needed)"
echo ""

docker run -it --rm \
    --name tellus-dev \
    -v "$SCRIPT_DIR:/home/dev/tellus" \
    -v "$HOME/.claude:/home/dev/.claude" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    "$IMAGE" \
    /bin/bash
