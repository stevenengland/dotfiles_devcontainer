#!/bin/bash
set -e

echo "Installing television..."
brew install fd
brew install bat
brew install television

echo "eval \"\$(tv init bash)\"" >> ~/.bashrc