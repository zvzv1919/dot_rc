#!/bin/bash

###############################################################################
# Setup SSH Key for GitHub
###############################################################################

set -e
source "$(dirname "$0")/common.sh"

check_macos

echo_info "SSH Key Setup"
echo ""

if [ -f "$HOME/.ssh/id_ed25519" ]; then
    echo_success "SSH key already exists at ~/.ssh/id_ed25519"
    echo_info "Your public key:"
    cat ~/.ssh/id_ed25519.pub
    echo ""
    echo_info "If you need to add this key to GitHub: https://github.com/settings/ssh/new"
    exit 0
fi

read -p "Enter your GitHub email: " github_email

if [ -z "$github_email" ]; then
    echo_error "Email is required"
    exit 1
fi

ssh-keygen -t ed25519 -C "$github_email"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

echo_success "SSH key generated"
echo_info "Your public key:"
cat ~/.ssh/id_ed25519.pub
echo ""
echo_info "Add this key to GitHub: https://github.com/settings/ssh/new"
