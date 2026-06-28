#!/bin/bash
set -e
# install-blesh.sh — idempotent ble.sh installer for dotfiles repos
# Uses a pre-built tarball (no git/make required)
# Pinned to devel3 (latest available release as of 2025)

BLESH_VERSION="0.4.0-devel3"
BLESH_URL="https://github.com/akinomyoga/ble.sh/releases/download/v${BLESH_VERSION}/ble-${BLESH_VERSION}.tar.xz"
BLESH_INSTALL_DIR="${HOME}/.local/share/blesh"
BLESH_ENTRY="${BLESH_INSTALL_DIR}/ble.sh"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib/bashrc.sh"

# ── Idempotency check ────────────────────────────────────────────────────────
if [[ -f "${BLESH_ENTRY}" ]]; then
    echo "[blesh] Already installed at ${BLESH_ENTRY}, skipping."
    exit 0
fi

# ── Dependency check ─────────────────────────────────────────────────────────
for cmd in curl tar; do
    if ! command -v "${cmd}" &>/dev/null; then
        echo "[blesh] ERROR: '${cmd}' is required but not found." >&2
        exit 1
    fi
done

# ── Download & install via temp dir ──────────────────────────────────────────
TMPDIR="$(mktemp -d)"
trap 'rm -rf "${TMPDIR}"' EXIT   # always clean up, even on failure

echo "[blesh] Downloading ble.sh ${BLESH_VERSION}..."
curl -fsSL "${BLESH_URL}" -o "${TMPDIR}/ble.tar.xz"

echo "[blesh] Extracting..."
tar xJf "${TMPDIR}/ble.tar.xz" -C "${TMPDIR}"

echo "[blesh] Installing to ${BLESH_INSTALL_DIR}..."
mkdir -p "${BLESH_INSTALL_DIR}"
cp -r "${TMPDIR}/ble-${BLESH_VERSION}/." "${BLESH_INSTALL_DIR}/"

# ── Wire ble.sh into .bashrc ─────────────────────────────────────────────────
bashrc_insert EARLY '[[ $- == *i* && -r "${HOME}/.local/share/blesh/ble.sh" ]] && source -- "${HOME}/.local/share/blesh/ble.sh" --attach=none'
bashrc_insert LATE  '[[ ${BLE_VERSION-} ]] && ble-attach'

echo "[blesh] Done — wired ble.sh into ~/.bashrc."