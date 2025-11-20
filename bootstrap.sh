#!/bin/bash

###############################################################################
# MacOS Developer Environment Bootstrap Script
# This script installs essential development tools and applications
###############################################################################

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

echo_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

echo_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

echo_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo_error "This script is designed for macOS only"
    exit 1
fi

echo_info "Starting macOS Developer Environment Bootstrap..."
echo ""

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

###############################################################################
# Install Essential CLI Tools
###############################################################################
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

###############################################################################
# Install Programming Languages and Tools
###############################################################################
echo_info "Installing programming languages and tools..."

LANGUAGES=(
    "python@3.12"   # Python
    "node"          # Node.js
    "go"            # Go
    "rust"          # Rust
)

for lang in "${LANGUAGES[@]}"; do
    if brew list "$lang" &> /dev/null; then
        echo_success "$lang already installed"
    else
        echo_info "Installing $lang..."
        brew install "$lang"
    fi
done

###############################################################################
# Install Development Applications (Casks)
###############################################################################
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
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    echo_info "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
    echo_success "zsh-autosuggestions already installed"
fi

# zsh-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    echo_info "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
    echo_success "zsh-syntax-highlighting already installed"
fi

###############################################################################
# Configure Git
###############################################################################
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

###############################################################################
# Install Python packages
###############################################################################
echo_info "Installing common Python packages..."
pip3 install --upgrade pip
pip3 install virtualenv ipython jupyter numpy pandas matplotlib requests

###############################################################################
# Setup SSH Key (optional)
###############################################################################
echo ""
read -p "Do you want to generate an SSH key for GitHub? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
        read -p "Enter your GitHub email: " github_email
        ssh-keygen -t ed25519 -C "$github_email"
        eval "$(ssh-agent -s)"
        ssh-add ~/.ssh/id_ed25519
        echo_success "SSH key generated"
        echo_info "Your public key:"
        cat ~/.ssh/id_ed25519.pub
        echo ""
        echo_info "Add this key to GitHub: https://github.com/settings/ssh/new"
    else
        echo_success "SSH key already exists"
    fi
fi

###############################################################################
# macOS System Preferences
###############################################################################
echo ""
read -p "Do you want to apply recommended macOS settings? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo_info "Applying macOS settings..."
    
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
    
    echo_success "macOS settings applied"
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
echo_success "Bootstrap Complete!"
echo_success "========================================"
echo ""
echo_info "Installed tools:"
echo "  ✓ Homebrew package manager"
echo "  ✓ Essential CLI tools (git, wget, curl, jq, etc.)"
echo "  ✓ Kubernetes tools (kubectl, k9s, kind)"
echo "  ✓ Programming languages (Python, Node.js, Go, Rust)"
echo "  ✓ Development applications (VS Code, Cursor, iTerm2, Docker, etc.)"
echo "  ✓ Oh My Zsh with plugins"
echo ""
echo_info "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Configure your .zshrc with your preferred Oh My Zsh theme and plugins"
echo "  3. If you generated an SSH key, add it to GitHub"
echo "  4. Install any additional tools specific to your workflow"
echo ""
echo_warning "Note: Some applications may require additional configuration"
echo ""

