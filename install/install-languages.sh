#!/bin/bash

###############################################################################
# Install Programming Languages and Runtimes
###############################################################################

set -e
source "$(dirname "$0")/common.sh"

check_macos
ensure_homebrew

echo_info "Installing programming languages and runtimes..."

LANGUAGES=(
    "python@3.12"   # Python
    "node"          # Node.js
    "go"            # Go
    "rust"          # Rust
)

for lang in "${LANGUAGES[@]}"; do
    if brew list "$lang" &> /dev/null; then
        echo_success "$lang already installed"
    else
        echo_info "Installing $lang..."
        brew install "$lang"
    fi
done

echo_success "Programming languages installation complete"
