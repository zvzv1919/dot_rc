#!/bin/bash

###############################################################################
# Install Common Python Packages
###############################################################################

set -e
source "$(dirname "$0")/common.sh"

check_macos

echo_info "Installing common Python packages..."

# Upgrade pip first
pip3 install --upgrade pip

# Install common packages
pip3 install virtualenv ipython jupyter numpy pandas matplotlib requests

echo_success "Python packages installation complete"
