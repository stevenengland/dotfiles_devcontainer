#!/bin/bash
# Idempotent insertion into marked regions of ~/.bashrc.
# Regions delimited by:  # [<NAME>:START] ... # [<NAME>:END]
#
# Usage:  bashrc_insert <REGION> "<line>"
# Inserts <line> just before the region's END marker, skipping if the exact
# line is already present. Override the target with the BASHRC env var.
BASHRC="${BASHRC:-$HOME/.bashrc}"

bashrc_insert() {
    local region="$1" line="$2"
    local end="# [${region}:END]"

    if ! grep -qxF "$end" "$BASHRC"; then
        echo "[bashrc] ERROR: region '${region}' missing in ${BASHRC}" >&2
        return 1
    fi
    grep -qxF -- "$line" "$BASHRC" && return 0   # already present → no-op

    local tmp; tmp="$(mktemp)"
    awk -v end="$end" -v ins="$line" '$0 == end { print ins } { print }' \
        "$BASHRC" > "$tmp"
    cat "$tmp" > "$BASHRC"   # truncate-write THROUGH the symlink (keeps symlink)
    rm -f "$tmp"
}
