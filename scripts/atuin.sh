#!/bin/bash
set -e

echo "Installing atuin..."
brew install atuin

# echo "eval \"\$(atuin init bash --disable-up-arrow)\"" >> ~/.bashrc
echo "eval \"\$(atuin init bash)\"" >> ~/.bashrc

# set config vars
ATUIN_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/atuin/config.toml"
mkdir -p "$(dirname "$ATUIN_CONFIG")"

# Write a clean config with only the values you care about
# Atuin uses defaults for anything not specified
cat > "$ATUIN_CONFIG" << 'EOF'
inline_height = 0
invert = false
EOF