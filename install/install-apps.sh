#!/bin/bash

###############################################################################
# Install GUI Applications via Homebrew Casks
###############################################################################

set -e
source "$(dirname "$0")/common.sh"

check_macos
ensure_homebrew

echo_info "Installing applications..."

CASKS=(
    "visual-studio-code"    # Code editor
    "cursor"               # AI-powered code editor
    "iterm2"               # Terminal emulator
    "docker"               # Containerization
    "postman"              # API testing
    "rectangle"            # Window management
    "google-chrome"        # Web browser
    "firefox"              # Web browser
    "slack"                # Team communication
    "zoom"                 # Video conferencing
    "wechat"               # Messaging
    "claude"               # Claude desktop app
    "claude-code"          # Claude Code CLI
    "steam"                # Gaming platform
    "github"               # GitHub Desktop
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
