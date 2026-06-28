#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib/bashrc.sh"

echo "Installing Z-AI..."
# Create the Z-AI profile directories so the aliases don't fail
mkdir -p ~/.z-ai-profiles/work ~/.z-ai-profiles/personal

# Only create symlinks if they don't already exist
[ -L /home/vscode/.z-ai-profiles/work/.local ]     || ln -s /home/vscode/.local /home/vscode/.z-ai-profiles/work/.local
[ -L /home/vscode/.z-ai-profiles/personal/.local ] || ln -s /home/vscode/.local /home/vscode/.z-ai-profiles/personal/.local

bashrc_insert INIT "alias zaiw='HOME=\$HOME/.z-ai-profiles/work XDG_CONFIG_HOME=\$HOME/.config claude'"
bashrc_insert INIT "alias zaip='HOME=\$HOME/.z-ai-profiles/personal XDG_CONFIG_HOME=\$HOME/.config claude'"