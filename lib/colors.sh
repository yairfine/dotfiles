#!/usr/bin/env bash

# Terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

# Print colored text
print_red() { echo -e "${RED}$*${NC}"; }
print_green() { echo -e "${GREEN}$*${NC}"; }
print_yellow() { echo -e "${YELLOW}$*${NC}"; }
print_blue() { echo -e "${BLUE}$*${NC}"; }
print_purple() { echo -e "${PURPLE}$*${NC}"; }
print_cyan() { echo -e "${CYAN}$*${NC}"; }
print_gray() { echo -e "${GRAY}$*${NC}"; }

# Formatting functions
bold() { echo -e "\033[1m$*\033[0m"; }
italic() { echo -e "\033[3m$*\033[0m"; }
underline() { echo -e "\033[4m$*\033[0m"; }

# Status functions
info() { print_blue "INFO: $*"; }
success() { print_green "SUCCESS: $*"; }
warning() { print_yellow "WARNING: $*"; }
error() { print_red "ERROR: $*"; }
