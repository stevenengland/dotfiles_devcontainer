#!/bin/bash
set -e

# Assumes passwordless sudo vscode user (devcontainer default)

echo "Installing Homebrew..."
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Bootstrap brew onto PATH for the rest of this script
echo >> "$HOME/.bashrc"
BREW_PREFIX=/home/linuxbrew/.linuxbrew
[ -d /opt/homebrew ] && BREW_PREFIX=/opt/homebrew
eval "$($BREW_PREFIX/bin/brew shellenv bash)"

echo "Installing packages..."
brew install gcc