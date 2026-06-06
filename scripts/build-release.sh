#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DIST_DIR="$ROOT_DIR/dist"
APP_DIR="$ROOT_DIR/apps/desktop"

echo "Building for aarch64-macos..."
(cd "$APP_DIR" && zig build -Dtarget=aarch64-macos -Doptimize=ReleaseSafe --prefix "$DIST_DIR/arm64")

echo "Building for x86_64-macos..."
(cd "$APP_DIR" && zig build -Dtarget=x86_64-macos -Doptimize=ReleaseSafe --prefix "$DIST_DIR/amd64")

BINARY_ARM="$DIST_DIR/arm64/bin/tinycord"
BINARY_AMD="$DIST_DIR/amd64/bin/tinycord"

if [ ! -f "$BINARY_ARM" ]; then
    echo "Error: arm64 binary not found at $BINARY_ARM"
    exit 1
fi

if [ ! -f "$BINARY_AMD" ]; then
    echo "Error: amd64 binary not found at $BINARY_AMD"
    exit 1
fi

mkdir -p "$DIST_DIR/tinycord_darwin_all"
lipo -create -output "$DIST_DIR/tinycord_darwin_all/tinycord" "$BINARY_ARM" "$BINARY_AMD"

rm -rf "$DIST_DIR/arm64" "$DIST_DIR/amd64"

echo "Universal binary created at $DIST_DIR/tinycord_darwin_all/tinycord"
file "$DIST_DIR/tinycord_darwin_all/tinycord"
