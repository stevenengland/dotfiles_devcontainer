#!/bin/bash
set -e

echo "Installing Claude CLI..."
# Create the Claude profile directories so the aliases don't fail
mkdir -p ~/.claude-profiles/work ~/.claude-profiles/personal

# Install native Claude Code CLI
curl -fsSL https://claude.ai/install.sh | bash

echo "alias claudew='HOME=$HOME/.claude-profiles/work claude'" >> ~/.bashrc
echo "alias claudep='HOME=$HOME/.claude-profiles/personal claude'" >> ~/.bashrc