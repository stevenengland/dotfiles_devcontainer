#!/bin/bash
set -e

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Symlink the .bashrc from the cloned dotfiles repo to the home directory
# This overwrites the default devcontainer .bashrc with yours
ln -sf ~/dotfiles/config/.bashrc ~/.bashrc
#ln -sf "$DOTFILES_DIR/config/.gitconfig" ~/.gitconfig

"$DOTFILES_DIR/scripts/brew.sh"
"$DOTFILES_DIR/scripts/sesh.sh"
"$DOTFILES_DIR/scripts/claude.sh"

# Source the .bashrc to apply the changes immediately
source ~/.bashrc