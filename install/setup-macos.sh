#!/bin/bash

###############################################################################
# Apply macOS System Preferences
###############################################################################

set -e
source "$(dirname "$0")/common.sh"

check_macos

echo_info "Applying macOS system preferences..."

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

# Disable "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Enable key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a faster keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Screenshot location
mkdir -p ~/Screenshots
defaults write com.apple.screencapture location ~/Screenshots

# Restart Finder to apply changes
killall Finder

echo_success "macOS system preferences applied"
