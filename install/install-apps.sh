#!/bin/bash

###############################################################################
# Install GUI Applications via Homebrew Casks
###############################################################################

set -e
source "$(dirname "$0")/common.sh"

check_macos
ensure_homebrew

echo_info "Installing development applications..."

CASKS=(
    "visual-studio-code"    # Code editor
    "cursor"               # AI-powered code editor
    "iterm2"               # Terminal emulator
    "docker"               # Containerization
    "postman"              # API testing
    "rectangle"            # Window management
)

for cask in "${CASKS[@]}"; do
    if brew list --cask "$cask" &> /dev/null; then
        echo_success "$cask already installed"
    else
        echo_info "Installing $cask..."
        brew install --cask "$cask" || echo_warning "Failed to install $cask (may require manual installation)"
    fi
done

echo_success "Applications installation complete"
