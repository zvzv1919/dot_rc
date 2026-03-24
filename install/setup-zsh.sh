#!/bin/bash

###############################################################################
# Setup Oh My Zsh and Plugins
###############################################################################

set -e
source "$(dirname "$0")/common.sh"

check_macos

###############################################################################
# Install Oh My Zsh
###############################################################################
echo_info "Checking for Oh My Zsh..."
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo_success "Oh My Zsh already installed"
else
    echo_info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://install.ohmyz.sh/)" "" --unattended
    echo_success "Oh My Zsh installed"
fi

###############################################################################
# Install Oh My Zsh Plugins
###############################################################################
echo_info "Installing Oh My Zsh plugins..."

# zsh-autosuggestions
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo_info "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
    echo_success "zsh-autosuggestions already installed"
fi

# zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo_info "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
    echo_success "zsh-syntax-highlighting already installed"
fi

echo_success "Oh My Zsh setup complete"
echo_info "To apply the config, copy ../config/.zshrc to ~/.zshrc and run: source ~/.zshrc"
