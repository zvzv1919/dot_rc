#!/bin/bash

###############################################################################
# Common functions and utilities for installation scripts
###############################################################################

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

echo_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

echo_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

echo_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Acquire sudo credentials upfront and keep them alive for the session.
# Call this once at the start; subsequent sudo calls won't re-prompt.
ensure_sudo() {
    echo_info "Requesting administrator privileges (you may be prompted for your password)..."
    sudo -v
    # Keep sudo alive in the background until this script's parent process exits
    while true; do sudo -n true; sleep 50; done 2>/dev/null &
    SUDO_KEEPALIVE_PID=$!
    trap 'kill $SUDO_KEEPALIVE_PID 2>/dev/null' EXIT
}

# Check if running on macOS
check_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        echo_error "This script is designed for macOS only"
        exit 1
    fi
}

# Ensure Homebrew is installed
ensure_homebrew() {
    if ! command -v brew &> /dev/null; then
        echo_error "Homebrew is not installed. Please run install-homebrew.sh first."
        exit 1
    fi
}
