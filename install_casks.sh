#!/usr/bin/env sh

DOT_FILES_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

echo "INSTALLING CASKS APPS ON YOUR SYSTEM"

if command -v brew &>/dev/null; then
    brew update
    xargs brew install --cask < "$DOT_FILES_DIR/casks.txt"
else
    echo "Homebrew could not be found, skipping casks apps"
fi
