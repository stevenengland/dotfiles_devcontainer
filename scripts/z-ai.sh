#!/bin/bash
set -e

echo "Installing Z-AI..."
# Create the Z-AI profile directories so the aliases don't fail
mkdir -p ~/.z-ai-profiles/work ~/.z-ai-profiles/personal

# Only create symlinks if they don't already exist
[ -L /home/vscode/.z-ai-profiles/work/.local ]     || ln -s /home/vscode/.local /home/vscode/.z-ai-profiles/work/.local
[ -L /home/vscode/.z-ai-profiles/personal/.local ] || ln -s /home/vscode/.local /home/vscode/.z-ai-profiles/personal/.local

echo "alias zaiw='HOME=$HOME/.z-ai-profiles/work XDG_CONFIG_HOME=$HOME/.config claude'" >> ~/.bashrc
echo "alias zaip='HOME=$HOME/.z-ai-profiles/personal XDG_CONFIG_HOME=$HOME/.config claude'" >> ~/.bashrc