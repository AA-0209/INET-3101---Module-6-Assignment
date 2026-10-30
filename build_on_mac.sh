#!/usr/bin/env bash
# Builds GNU Coreutils 9.7 into ./build/coreutils-9.7 (macOS)
# Requires Xcode Command Line Tools: xcode-select --install
# Safe to re-run: it will NOT re-extract the source, so your edits are kept.
set -e

VER=9.7
ROOT="$(cd "$(dirname "$0")" && pwd)"
mkdir -p "$ROOT/build"
cd "$ROOT/build"

if ! command -v cc >/dev/null 2>&1; then
  echo "C compiler not found. Run: xcode-select --install"
  exit 1
fi

if [ ! -d "coreutils-$VER" ]; then
  echo "==> Downloading coreutils-$VER"
  curl -LO "https://ftp.gnu.org/gnu/coreutils/coreutils-$VER.tar.xz"
  tar -xf "coreutils-$VER.tar.xz"
fi

cd "coreutils-$VER"

if [ ! -f Makefile ]; then
  echo "==> Configuring"
  ./configure
fi

echo "==> Compiling"
make -j"$(sysctl -n hw.ncpu)"

echo
echo "Build complete:"
echo "  $ROOT/build/coreutils-$VER/src/ls"
echo "  $ROOT/build/coreutils-$VER/src/whoami"
