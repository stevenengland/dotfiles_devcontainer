#!/bin/bash
set -e

echo "Installing rtk..."

brew install rtk

RTK_TELEMETRY_DISABLED=1 rtk init -g --auto-patch