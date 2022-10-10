#!/usr/bin/env bash

DOT_FILES_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

echo "INSTALLING PACKAGES ON YOUR SYSTEM"

if command -v python3 &>/dev/null; then
    python3 -m pip install --upgrade pip
    python3 -m pip install -r "$DOT_FILES_DIR/requirements.txt"
else
    echo "python3 could not be found, skipping pip packages"
fi

if command -v brew &>/dev/null; then
    brew update
    xargs brew install <"$DOT_FILES_DIR/brews.txt"
    git lfs install
else
    echo "Homebrew could not be found, skipping brew packages"
fi

