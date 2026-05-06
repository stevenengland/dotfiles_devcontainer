#!/bin/bash
set -e

echo "Installing Z-AI..."
# Create the Z-AI profile directories so the aliases don't fail
mkdir -p ~/.z-ai-profiles/work ~/.z-ai-profiles/personal