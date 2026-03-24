#!/bin/bash

###############################################################################
# Main Installation Script - Orchestrates All Setup Steps
###############################################################################

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/common.sh"

check_macos

echo_info "Starting macOS Developer Environment Setup..."
echo ""

###############################################################################
# Core Installation (Non-Interactive)
###############################################################################
echo_info "===== Installing Core Components ====="
echo ""

# Homebrew (required for everything else)
bash "$SCRIPT_DIR/install-homebrew.sh"
echo ""

# CLI Tools
bash "$SCRIPT_DIR/install-cli-tools.sh"
echo ""

# Programming Languages
bash "$SCRIPT_DIR/install-languages.sh"
echo ""

# GUI Applications
bash "$SCRIPT_DIR/install-apps.sh"
echo ""

# Oh My Zsh
bash "$SCRIPT_DIR/setup-zsh.sh"
echo ""

###############################################################################
# Optional Configuration (Interactive)
###############################################################################
echo_info "===== Optional Setup Steps ====="
echo ""

# Git Configuration
read -p "Do you want to configure Git? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    bash "$SCRIPT_DIR/setup-git.sh"
    echo ""
fi

# Python Packages
read -p "Do you want to install common Python packages? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    bash "$SCRIPT_DIR/setup-python.sh"
    echo ""
fi

# SSH Key
read -p "Do you want to generate an SSH key for GitHub? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    bash "$SCRIPT_DIR/setup-ssh.sh"
    echo ""
fi

# macOS Settings
read -p "Do you want to apply recommended macOS settings? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    bash "$SCRIPT_DIR/setup-macos.sh"
    echo ""
fi

###############################################################################
# Cleanup
###############################################################################
echo_info "Cleaning up..."
brew cleanup

###############################################################################
# Summary
###############################################################################
echo ""
echo_success "========================================"
echo_success "Installation Complete!"
echo_success "========================================"
echo ""
echo_info "Next steps:"
echo "  1. Copy config files: cp ../config/.zshrc ~/.zshrc"
echo "  2. Restart your terminal or run: source ~/.zshrc"
echo "  3. Review ../config/README.md for additional configurations"
echo ""
