#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib/bashrc.sh"

echo "Installing Claude CLI..."
# Create the Claude profile directories so the aliases don't fail
mkdir -p ~/.claude-profiles/work ~/.claude-profiles/personal

# Only create symlinks if they don't already exist
[ -L /home/vscode/.claude-profiles/work/.local ]     || ln -s /home/vscode/.local ~/.claude-profiles/work/.local
[ -L /home/vscode/.claude-profiles/personal/.local ] || ln -s /home/vscode/.local ~/.claude-profiles/personal/.local

# Restore a real Claude config backup BEFORE installing, so that the installer's
# `claude install` step (which runs the binary) finds an existing ~/.claude.json
# and does not create a fresh/dummy one. The same applies to the work/personal
# profile homes used by the claudew/claudep aliases — each gets restored from its
# own backups before it is ever launched. Backups live on the mounted docker
# volume and are named .claude.json.backup.<epoch-ms>. The newest backup can be a
# near-empty/dummy config, so we walk backups newest -> oldest and pick the first
# one whose JSON has numStartups > 1 (a config that was actually used).

# Read .numStartups from a backup (jq if available, else a grep fallback).
claude_numstartups() {
  if command -v jq >/dev/null 2>&1; then
    jq -r '.numStartups // 0' "$1" 2>/dev/null
  else
    grep -oE '"numStartups"[[:space:]]*:[[:space:]]*[0-9]+' "$1" 2>/dev/null | grep -oE '[0-9]+' | head -n1
  fi
}

# Restore <home>/.claude.json from the newest backup with numStartups>1 in
# <home>/.claude/backups. No-op if a config already exists (never overwritten)
# or if no backups dir / no suitable backup is present.
restore_claude_config() {
  local home="$1"
  local config="$home/.claude.json"
  local backup_dir="$home/.claude/backups"
  [ -f "$config" ] && return 0
  [ -d "$backup_dir" ] || return 0

  local backup starts restore_backup=""
  while IFS= read -r backup; do
    [ -f "$backup" ] || continue
    starts=$(claude_numstartups "$backup"); [ -z "$starts" ] && starts=0
    if [ "$starts" -gt 1 ] 2>/dev/null; then
      restore_backup="$backup"
      break
    fi
  done < <(ls -t "$backup_dir"/.claude.json.backup.* 2>/dev/null)

  if [ -n "$restore_backup" ]; then
    cp "$restore_backup" "$config"
    echo "Restored Claude config for $home from $restore_backup (numStartups>1)"
  else
    echo "No Claude config backup with numStartups>1 found for $home."
  fi
}

echo "Checking for existing Claude config(s)..."
restore_claude_config "$HOME"
restore_claude_config "$HOME/.claude-profiles/work"
restore_claude_config "$HOME/.claude-profiles/personal"

# Install native Claude Code CLI
curl -fsSL https://claude.ai/install.sh | bash

bashrc_insert INIT "alias claudew='HOME=\$HOME/.claude-profiles/work XDG_CONFIG_HOME=\$HOME/.config claude'"
bashrc_insert INIT "alias claudep='HOME=\$HOME/.claude-profiles/personal XDG_CONFIG_HOME=\$HOME/.config claude'"