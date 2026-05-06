#!/bin/bash
set -e

brew install sesh

# Generate completion script
sesh completion bash > sesh-completion.bash

# Or install user-only
mkdir -p ~/.local/share/bash-completion/completions
cp sesh-completion.bash ~/.local/share/bash-completion/completions/sesh