#!/bin/bash

###############################################################################
# Export config/credential files for laptop migration
# Creates a tarball and Brewfile on the Desktop for transfer.
###############################################################################

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../install/common.sh"

check_macos

OUTPUT_DIR="$HOME/Desktop/laptop-migration"
TARBALL="$OUTPUT_DIR/migration-configs.tar.gz"
BREWFILE="$OUTPUT_DIR/Brewfile"

mkdir -p "$OUTPUT_DIR"

echo_info "Dumping Homebrew bundle..."
brew bundle dump --file="$BREWFILE" --force
echo_success "Brewfile written to $BREWFILE"

echo_info "Collecting config and credential files..."

TAR_ARGS=()

add_path() {
    local path="$1"
    if [ -e "$path" ]; then
        TAR_ARGS+=("$path")
    else
        echo_warning "Not found, skipping: $path"
    fi
}

# --- 1. Credentials and Secrets ---
add_path "$HOME/.ssh"
add_path "$HOME/.aws"
add_path "$HOME/.kube/config"
add_path "$HOME/.config/gh"
add_path "$HOME/.docker/config.json"
add_path "$HOME/.docker/daemon.json"

# --- 2. Shell and Git Config ---
add_path "$HOME/.gitconfig"
add_path "$HOME/.zshrc"
add_path "$HOME/.zsh_history"
add_path "$HOME/.z"

# --- 3. Dev Tool Configs ---
add_path "$HOME/Library/Application Support/Cursor/User/settings.json"
add_path "$HOME/Library/Application Support/Cursor/User/keybindings.json"
add_path "$HOME/Library/Preferences/com.googlecode.iterm2.plist"

if [ ${#TAR_ARGS[@]} -eq 0 ]; then
    echo_error "No files found to archive."
    exit 1
fi

echo_info "Creating tarball..."
tar czf "$TARBALL" \
    --exclude='.ssh/agent' \
    --exclude='.ssh/*.sock' \
    "${TAR_ARGS[@]}" 2>/dev/null

echo_success "Migration archive created: $TARBALL"
echo_info "Brewfile created: $BREWFILE"
echo ""
echo_info "Transfer the entire $OUTPUT_DIR folder to the new laptop."
echo_info "Then run config/migrate-import.sh from this repo to apply."
