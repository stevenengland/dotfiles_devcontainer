#!/bin/bash
set -e

echo "Starting dotfiles installation..."

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Dotfiles directory: $DOTFILES_DIR"

echo "Symlinking from $DOTFILES_DIR/* to ~/*"
# Symlink the .bashrc from the cloned dotfiles repo to the home directory
# This overwrites the default devcontainer .bashrc with yours
ln -sf ~/dotfiles/config/.bashrc ~/.bashrc
#ln -sf "$DOTFILES_DIR/config/.gitconfig" ~/.gitconfig

echo "Installing dependencies..."

# ORDER MATTERS!

# Source instead of executing the brew script so that the Homebrew path is available for the rest of the installation
source "$DOTFILES_DIR/scripts/brew.sh"
"$DOTFILES_DIR/scripts/sesh.sh"
"$DOTFILES_DIR/scripts/television.sh"
"$DOTFILES_DIR/scripts/atuin.sh"
"$DOTFILES_DIR/scripts/blesh.sh"
"$DOTFILES_DIR/scripts/claude.sh"
"$DOTFILES_DIR/scripts/z-ai.sh"
"$DOTFILES_DIR/scripts/rtk.sh"
"$DOTFILES_DIR/scripts/bun.sh"