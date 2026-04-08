#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
IMAGE_NAME="${IMAGE_NAME:-chatbrandit:main}"
BUILD_CONTEXT="${BUILD_CONTEXT:-$(mktemp -d "${TMPDIR:-/tmp}/chatbrandit-ce-build.XXXXXX")}"
KEEP_CONTEXT="${KEEP_CONTEXT:-0}"

cleanup() {
  if [[ "$KEEP_CONTEXT" != "1" ]]; then
    rm -rf "$BUILD_CONTEXT"
  fi
}

trap cleanup EXIT

echo "Preparing CE build context at $BUILD_CONTEXT"
rsync -a --delete \
  --exclude 'enterprise' \
  --exclude 'spec/enterprise' \
  --exclude 'node_modules' \
  "$ROOT_DIR/" "$BUILD_CONTEXT/"

if ! grep -q 'CW_EDITION="ce"' "$BUILD_CONTEXT/docker/Dockerfile"; then
  printf '\nENV CW_EDITION="ce"\n' >> "$BUILD_CONTEXT/docker/Dockerfile"
fi

echo "Building Docker image $IMAGE_NAME"
docker build -t "$IMAGE_NAME" -f "$BUILD_CONTEXT/docker/Dockerfile" "$BUILD_CONTEXT"

echo "Built $IMAGE_NAME"
