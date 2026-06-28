#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib/bashrc.sh"

echo "Installing television..."
brew install fd
brew install bat
brew install television

bashrc_insert INIT 'eval "$(tv init bash)"'