#!/usr/bin/env bash
# Qbit Linux - ISO build script
#
# Usage:  ./build.sh
#
# The image is built in ./build (a root-owned copy of this tree, so file ownership inside
# the ISO is correct) and the result is placed in ./out together with its checksum.
# Needs sudo, an internet connection and about 20 GB of free disk space.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORK="$ROOT/build"
OUT="$ROOT/out"
REAL_USER="${SUDO_USER:-$(id -un)}"

if [ "$(id -u)" -ne 0 ]; then
    exec sudo -E "$0" "$@"
fi

if ! command -v lb >/dev/null 2>&1; then
    echo "Installing live-build ..."
    apt-get update
    apt-get install -y live-build
fi

avail_gb="$(df --output=avail -BG "$ROOT" | tail -1 | tr -dc '0-9')"
if [ "${avail_gb:-0}" -lt 20 ]; then
    echo "Need at least 20 GB free in $ROOT (found ${avail_gb:-0} GB)." >&2
    exit 1
fi

rm -rf "$WORK"
mkdir -p "$WORK" "$OUT"
cp -a "$ROOT/auto" "$ROOT/config" "$WORK/"
chown -R root:root "$WORK"
cd "$WORK"

lb config
if command -v systemd-inhibit >/dev/null 2>&1; then
    systemd-inhibit --what=sleep:idle --why="Qbit Linux build" lb build
else
    lb build
fi

iso="$(ls -1 ./*.iso 2>/dev/null | head -1 || true)"
if [ -z "$iso" ]; then
    echo "Build failed: no ISO was produced. See $WORK/build.log" >&2
    exit 1
fi
mv "$iso" "$OUT/"
cp -f build.log "$OUT/" 2>/dev/null || true
( cd "$OUT" && sha256sum ./*.iso > SHA256SUMS )
chown -R "$REAL_USER": "$OUT"

echo
echo "Done."
ls -lh "$OUT"
