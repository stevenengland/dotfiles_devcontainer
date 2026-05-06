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
"$DOTFILES_DIR/scripts/brew.sh"
"$DOTFILES_DIR/scripts/sesh.sh"
"$DOTFILES_DIR/scripts/claude.sh"