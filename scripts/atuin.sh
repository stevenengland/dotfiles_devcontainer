#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib/bashrc.sh"

echo "Installing atuin..."
brew install atuin

# bashrc_insert INIT 'eval "$(atuin init bash --disable-up-arrow)"'
bashrc_insert INIT 'eval "$(atuin init bash)"'

# set config vars
ATUIN_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/atuin/config.toml"
mkdir -p "$(dirname "$ATUIN_CONFIG")"

# Write a clean config with only the values you care about
# Atuin uses defaults for anything not specified
cat > "$ATUIN_CONFIG" << 'EOF'
inline_height = 0
invert = false
EOF