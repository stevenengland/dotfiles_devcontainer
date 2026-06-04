#!/bin/bash
set -e

echo "Installing Claude CLI..."
# Create the Claude profile directories so the aliases don't fail
mkdir -p ~/.claude-profiles/work ~/.claude-profiles/personal

# Only create symlinks if they don't already exist
[ -L /home/vscode/.claude-profiles/work/.local ]     || ln -s /home/vscode/.local ~/.claude-profiles/work/.local
[ -L /home/vscode/.claude-profiles/personal/.local ] || ln -s /home/vscode/.local ~/.claude-profiles/personal/.local

# Install native Claude Code CLI
curl -fsSL https://claude.ai/install.sh | bash

echo "alias claudew='HOME=$HOME/.claude-profiles/work XDG_CONFIG_HOME=$HOME/.config claude'" >> ~/.bashrc
echo "alias claudep='HOME=$HOME/.claude-profiles/personal XDG_CONFIG_HOME=$HOME/.config claude'" >> ~/.bashrc