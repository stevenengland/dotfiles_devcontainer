#!/bin/bash
set -e

echo "Installing rtk..."

brew install rtk

rtk init -g --auto-patch