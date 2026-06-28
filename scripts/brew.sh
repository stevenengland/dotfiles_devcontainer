#!/bin/bash
set -e
# Assumes passwordless sudo vscode user (devcontainer default)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib/bashrc.sh"

echo "Installing Homebrew..."
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Detect prefix
BREW_PREFIX=/home/linuxbrew/.linuxbrew
[ -d /opt/homebrew ] && BREW_PREFIX=/opt/homebrew

# Persist to .bashrc for future shells/scripts (runs first, so lands at top of INIT)
bashrc_insert INIT "eval \"\$(${BREW_PREFIX}/bin/brew shellenv bash)\""

# Bootstrap into current shell
eval "$($BREW_PREFIX/bin/brew shellenv bash)"

echo "Installing packages..."
brew install gcc