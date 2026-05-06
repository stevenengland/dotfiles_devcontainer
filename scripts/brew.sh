#!/bin/bash
set -e
# Assumes passwordless sudo vscode user (devcontainer default)

echo "Installing Homebrew..."
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Detect prefix
BREW_PREFIX=/home/linuxbrew/.linuxbrew
[ -d /opt/homebrew ] && BREW_PREFIX=/opt/homebrew

# Persist to .bashrc for future shells/scripts
echo >> "$HOME/.bashrc"
echo "eval \"\$(${BREW_PREFIX}/bin/brew shellenv bash)\"" >> "$HOME/.bashrc"

# Bootstrap into current shell
eval "$($BREW_PREFIX/bin/brew shellenv bash)"

echo "Installing packages..."
brew install gcc