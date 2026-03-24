#!/bin/bash

###############################################################################
# Install Homebrew and Command Line Tools
###############################################################################

set -e
source "$(dirname "$0")/common.sh"

check_macos

###############################################################################
# Install Command Line Tools
###############################################################################
echo_info "Checking for Command Line Tools..."
if ! xcode-select -p &> /dev/null; then
    echo_info "Installing Command Line Tools..."
    xcode-select --install
    echo_warning "Please complete the Command Line Tools installation and re-run this script"
    exit 0
else
    echo_success "Command Line Tools already installed"
fi

###############################################################################
# Install Homebrew
###############################################################################
echo_info "Checking for Homebrew..."
if ! command -v brew &> /dev/null; then
    echo_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    echo_success "Homebrew installed"
else
    echo_success "Homebrew already installed"
    echo_info "Updating Homebrew..."
    brew update
fi

echo_success "Homebrew setup complete"
