#!/bin/bash

###############################################################################
# Configure Git
###############################################################################

set -e
source "$(dirname "$0")/common.sh"

check_macos

echo_info "Configuring Git..."

if [ -z "$(git config --global user.name)" ]; then
    read -p "Enter your Git username: " git_username
    git config --global user.name "$git_username"
fi

if [ -z "$(git config --global user.email)" ]; then
    read -p "Enter your Git email: " git_email
    git config --global user.email "$git_email"
fi

# Set useful Git defaults
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global core.editor vim

echo_success "Git configured"
