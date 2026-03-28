#!/bin/bash

###############################################################################
# Import config/credential files on a new laptop
# Extracts the migration tarball and applies each config independently.
# Prints a final report of successes and failures.
###############################################################################

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../install/common.sh"

check_macos

MIGRATION_DIR="${1:-$HOME/Desktop/laptop-migration}"
TARBALL="$MIGRATION_DIR/migration-configs.tar.gz"
BREWFILE="$MIGRATION_DIR/Brewfile"
STAGING="$MIGRATION_DIR/staging"

SUCCESSES=()
FAILURES=()

report_ok()   { SUCCESSES+=("$1"); echo_success "$1"; }
report_fail() { FAILURES+=("$1: $2"); echo_error "$1 -- $2"; }

# ---------------------------------------------------------------------------
# Preflight
# ---------------------------------------------------------------------------

if [ ! -f "$TARBALL" ]; then
    echo_error "Tarball not found at $TARBALL"
    echo_info  "Usage: $0 [path/to/laptop-migration]"
    exit 1
fi

echo_info "Extracting tarball to staging area..."
rm -rf "$STAGING"
mkdir -p "$STAGING"
tar xzf "$TARBALL" -C "$STAGING" 2>/dev/null
echo_success "Extraction complete."

# Resolve the home-dir prefix inside the staging area.
# tar preserves absolute paths so files land under staging/Users/<user>/...
STAGED_HOME="$STAGING$HOME"
if [ ! -d "$STAGED_HOME" ]; then
    STAGED_HOME="$STAGING"
fi

# ---------------------------------------------------------------------------
# Helper: copy a file/dir from staging to its real destination
# ---------------------------------------------------------------------------
apply_item() {
    local label="$1"
    local src="$2"
    local dest="$3"

    if [ ! -e "$src" ]; then
        report_fail "$label" "not found in archive"
        return
    fi

    mkdir -p "$(dirname "$dest")"

    if [ -d "$src" ]; then
        cp -Rn "$src/." "$dest/" 2>/dev/null   # merge, don't clobber
        # shellcheck disable=SC2181
        if [ $? -eq 0 ]; then report_ok "$label"; else report_fail "$label" "cp failed"; fi
    else
        if [ -f "$dest" ]; then
            echo_warning "$label: destination exists, backing up to ${dest}.bak"
            cp "$dest" "${dest}.bak" 2>/dev/null
        fi
        cp "$src" "$dest" 2>/dev/null
        if [ $? -eq 0 ]; then report_ok "$label"; else report_fail "$label" "cp failed"; fi
    fi
}

# ---------------------------------------------------------------------------
# Apply each config independently
# ---------------------------------------------------------------------------

echo ""
echo_info "=== Applying configs ==="
echo ""

apply_item "SSH keys and config"   "$STAGED_HOME/.ssh"                        "$HOME/.ssh"
chmod 700 "$HOME/.ssh" 2>/dev/null
chmod 600 "$HOME/.ssh/id_ed25519" 2>/dev/null

apply_item "AWS config"            "$STAGED_HOME/.aws"                        "$HOME/.aws"
apply_item "Kubernetes config"     "$STAGED_HOME/.kube/config"                "$HOME/.kube/config"
apply_item "GitHub CLI config"     "$STAGED_HOME/.config/gh"                  "$HOME/.config/gh"
apply_item "Docker config.json"    "$STAGED_HOME/.docker/config.json"         "$HOME/.docker/config.json"
apply_item "Docker daemon.json"    "$STAGED_HOME/.docker/daemon.json"         "$HOME/.docker/daemon.json"
apply_item "Git config"            "$STAGED_HOME/.gitconfig"                  "$HOME/.gitconfig"
apply_item "Zsh config"            "$STAGED_HOME/.zshrc"                      "$HOME/.zshrc"
apply_item "Zsh history"           "$STAGED_HOME/.zsh_history"                "$HOME/.zsh_history"
apply_item "z database"            "$STAGED_HOME/.z"                          "$HOME/.z"

apply_item "Cursor settings.json"  \
    "$STAGED_HOME/Library/Application Support/Cursor/User/settings.json" \
    "$HOME/Library/Application Support/Cursor/User/settings.json"

apply_item "Cursor keybindings"    \
    "$STAGED_HOME/Library/Application Support/Cursor/User/keybindings.json" \
    "$HOME/Library/Application Support/Cursor/User/keybindings.json"

apply_item "iTerm2 preferences"    \
    "$STAGED_HOME/Library/Preferences/com.googlecode.iterm2.plist" \
    "$HOME/Library/Preferences/com.googlecode.iterm2.plist"

# ---------------------------------------------------------------------------
# Homebrew bundle
# ---------------------------------------------------------------------------

echo ""
echo_info "=== Homebrew bundle ==="
echo ""

if [ -f "$BREWFILE" ]; then
    echo_info "Installing packages from Brewfile (this may take a while)..."
    if brew bundle --file="$BREWFILE" --no-upgrade; then
        report_ok "Homebrew bundle"
    else
        report_fail "Homebrew bundle" "some packages failed (see output above)"
    fi
else
    report_fail "Homebrew bundle" "Brewfile not found at $BREWFILE"
fi

# ---------------------------------------------------------------------------
# Cleanup staging
# ---------------------------------------------------------------------------

rm -rf "$STAGING"

# ---------------------------------------------------------------------------
# Final report
# ---------------------------------------------------------------------------

echo ""
echo "==========================================="
echo "           MIGRATION REPORT"
echo "==========================================="
echo ""

if [ ${#SUCCESSES[@]} -gt 0 ]; then
    echo_success "Applied successfully (${#SUCCESSES[@]}):"
    for item in "${SUCCESSES[@]}"; do
        echo "  ✓ $item"
    done
fi

echo ""

if [ ${#FAILURES[@]} -gt 0 ]; then
    echo_error "Failed (${#FAILURES[@]}):"
    for item in "${FAILURES[@]}"; do
        echo "  ✗ $item"
    done
    echo ""
    echo_warning "Review the failures above and apply manually if needed."
    exit 1
else
    echo_success "All items applied successfully!"
fi
