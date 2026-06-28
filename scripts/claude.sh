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

# Install native Claude Code CLI
curl -fsSL https://claude.ai/install.sh | bash

# Restore the most recent Claude config backup if no config is present.
# Backups are named .claude.json.backup.<epoch-ms>, so the newest by mtime is
# also the newest by timestamp.
CLAUDE_CONFIG="$HOME/.claude.json"
CLAUDE_BACKUP_DIR="$HOME/.claude/backups"
if [ ! -f "$CLAUDE_CONFIG" ] && [ -d "$CLAUDE_BACKUP_DIR" ]; then
  latest_backup=$(ls -t "$CLAUDE_BACKUP_DIR"/.claude.json.backup.* 2>/dev/null | head -n1)
  if [ -n "$latest_backup" ]; then
    cp "$latest_backup" "$CLAUDE_CONFIG"
    echo "Restored Claude config from $latest_backup"
  else
    echo "No Claude config backup found to restore."
  fi
fi

bashrc_insert INIT "alias claudew='HOME=\$HOME/.claude-profiles/work XDG_CONFIG_HOME=\$HOME/.config claude'"
bashrc_insert INIT "alias claudep='HOME=\$HOME/.claude-profiles/personal XDG_CONFIG_HOME=\$HOME/.config claude'"