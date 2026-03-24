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
