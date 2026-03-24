#!/bin/bash

###############################################################################
# Install Essential CLI Tools
###############################################################################

set -e
source "$(dirname "$0")/common.sh"

check_macos
ensure_homebrew

echo_info "Installing essential CLI tools..."

CLI_TOOLS=(
    "git"           # Version control
    "wget"          # File download
    "curl"          # Data transfer
    "tree"          # Directory visualization
    "jq"            # JSON processor
    "htop"          # Process viewer
    "vim"           # Text editor
    "tmux"          # Terminal multiplexer
    "ripgrep"       # Fast grep alternative
    "fzf"           # Fuzzy finder
    "bat"           # Better cat
    "eza"           # Better ls
    "gh"            # GitHub CLI
    "gnupg"         # GPG encryption
    "kubectl"       # Kubernetes CLI
    "k9s"           # Kubernetes TUI
    "kind"          # Kubernetes in Docker
    "openssl"       # SSL/TLS toolkit
)

for tool in "${CLI_TOOLS[@]}"; do
    if brew list "$tool" &> /dev/null; then
        echo_success "$tool already installed"
    else
        echo_info "Installing $tool..."
        brew install "$tool"
    fi
done

echo_success "CLI tools installation complete"
