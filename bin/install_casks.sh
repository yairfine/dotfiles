#!/usr/bin/env sh

DOTFILES_DIT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

echo "INSTALLING CASKS APPS ON YOUR SYSTEM"

if command -v brew &>/dev/null; then
    brew update
    xargs brew install --cask < "$DOTFILES_DIT/casks.txt"
else
    echo "Homebrew could not be found, skipping casks apps"
fi
