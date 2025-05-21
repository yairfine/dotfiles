#!/usr/bin/env bash

# Check if a command exists
command_exists() {
    command -v "$1" &>/dev/null
}

# Check if a directory exists
dir_exists() {
    [[ -d "$1" ]]
}

# Check if a file exists
file_exists() {
    [[ -f "$1" ]]
}

# Find repositories by pattern
find_repos() {
    local pattern="$1"
    local base_dir="${2:-$HOME/repos}"

    find "$base_dir" -maxdepth 1 -type d -name "$pattern" 2>/dev/null
}

# Confirm action
confirm() {
    local prompt="${1:-Are you sure?}"
    local default="${2:-n}"

    if [[ "$default" == "y" ]]; then
        prompt="$prompt [Y/n] "
    else
        prompt="$prompt [y/N] "
    fi

    read -r -p "$prompt" response
    response=${response,,} # Convert to lowercase

    if [[ "$default" == "y" ]]; then
        [[ "$response" != "n" && "$response" != "no" ]]
    else
        [[ "$response" == "y" || "$response" == "yes" ]]
    fi
}

# Check if running on macOS
is_macos() {
    [[ "$(uname -s)" == "Darwin" ]]
}

# Check if running on Linux
is_linux() {
    [[ "$(uname -s)" == "Linux" ]]
}

# Add a directory to PATH if it exists and isn't already in PATH
add_to_path() {
    local dir="$1"
    if [[ -d "$dir" && ":$PATH:" != *":$dir:"* ]]; then
        export PATH="$dir:$PATH"
    fi
}

# Source a file if it exists
source_if_exists() {
    local file="$1"
    if [[ -f "$file" ]]; then
        source "$file"
    fi
}
