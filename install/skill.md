# Automated Installation Skill

This document describes the automated execution plan for setting up a macOS development environment using the scripts in this directory.

## Execution Plan

### Phase 1: Prerequisites (REQUIRED)
**Must complete before proceeding to Phase 2**

```bash
./install/install-homebrew.sh
```

**Critical Checkpoints:**
- Xcode Command Line Tools installed
- Homebrew installed and in PATH
- `brew --version` returns successfully

**Failure Handling:**
- If Command Line Tools installation is triggered, STOP and wait for completion
- If Homebrew fails to install, STOP entire process (cannot continue)
- Log failure and exit with status code

### Phase 2: Core Installations (PARALLEL)
**Can run independently after Phase 1**

Execute in parallel or sequential order:

```bash
./install/install-cli-tools.sh      # ~20 packages
./install/install-languages.sh      # ~4 languages
./install/install-apps.sh           # ~6 GUI applications
./install/setup-zsh.sh              # Oh My Zsh + plugins
```

**Failure Handling:**
- Each script is independent - failure in one does not block others
- Skip failed individual packages/apps, continue with rest
- Record each failure with script name and item that failed
- Do NOT retry failed items in a loop
- Continue to Phase 3 even if some Phase 2 scripts fail

### Phase 3: Optional Configuration (INTERACTIVE)
**Requires user input - skip if non-interactive**

```bash
./install/setup-git.sh              # Prompts for name/email
./install/setup-python.sh           # No prompts, safe to auto-run
./install/setup-ssh.sh              # Prompts for GitHub email
./install/setup-macos.sh            # No prompts, safe to auto-run
```

**Failure Handling:**
- If non-interactive mode: Skip scripts that require prompts
- If interactive mode: Present prompts, skip on timeout or invalid input
- Record which configuration steps were skipped
- All configuration scripts can be re-run later

## Execution Modes

### Automated Mode (No User Interaction)
```bash
# Phase 1
./install/install-homebrew.sh

# Phase 2 (parallel if possible)
./install/install-cli-tools.sh &
./install/install-languages.sh &
./install/install-apps.sh &
./install/setup-zsh.sh &
wait

# Phase 3 (auto-run safe scripts only)
./install/setup-python.sh
./install/setup-macos.sh
```

**Skip:** setup-git.sh, setup-ssh.sh (require user input)

### Interactive Mode (With User Prompts)
```bash
# Run the orchestrator script
./install/install.sh
```

This handles all phases with user prompts for optional configurations.

## Failure Logging

### Log Location
Create log file: `./install/installation.log`

### Log Entry Format
```
[YYYY-MM-DD HH:MM:SS] START: <script_name>
[YYYY-MM-DD HH:MM:SS] SUCCESS: <script_name>
```

or

```
[YYYY-MM-DD HH:MM:SS] START: <script_name>
[YYYY-MM-DD HH:MM:SS] FAILURE: <script_name>
  Item: <package/app/config that failed>
  Error: <error message>
  Action: Skipped and continued
[YYYY-MM-DD HH:MM:SS] PARTIAL: <script_name> (X/Y items succeeded)
```

### Summary Report Format
```
=== Installation Summary ===
Date: <timestamp>
Total Scripts: X
Successful: Y
Failed: Z

=== Installed Components ===
✓ Homebrew
✓ CLI Tools: 18/20 (failed: htop, k9s)
✓ Languages: 4/4
✗ Apps: 4/6 (failed: docker, cursor)
✓ Oh My Zsh
✓ Python Packages: 8/8
⊘ Git Config (skipped - no user input)
✓ macOS Preferences

=== Failed Items ===
- htop: Already installed by system
- k9s: Download timeout
- docker: Requires Rosetta2 installation
- cursor: License agreement required
- setup-git.sh: Skipped (non-interactive mode)

=== Next Steps ===
Manually install failed items:
  brew install htop k9s
  brew install --cask docker cursor
  ./install/setup-git.sh
```

## Recovery Procedures

### After Failure
1. Review `installation.log` for specific errors
2. Fix underlying issues (network, permissions, etc.)
3. Re-run specific failed scripts:
   ```bash
   ./install/<failed-script>.sh
   ```
4. Scripts are idempotent - already-installed items will be skipped

### Common Recovery Actions

**Network timeouts:**
```bash
# Retry just the failed script
./install/install-apps.sh
```

**Homebrew issues:**
```bash
brew update
brew doctor
# Fix issues, then re-run
./install/install-cli-tools.sh
```

**Permission issues:**
```bash
sudo chown -R $(whoami) /usr/local/Homebrew
# Re-run failed script
```

**Cask failures:**
```bash
# Some casks fail silently, install manually
brew install --cask <app-name>
```

## Validation

### Post-Installation Checks
```bash
# Verify Homebrew
brew --version

# Verify languages
python3 --version
node --version
go version
rustc --version

# Verify CLI tools
command -v git gh kubectl k9s jq fzf rg

# Verify Oh My Zsh
[ -d ~/.oh-my-zsh ] && echo "✓ Oh My Zsh installed"

# Verify applications
ls /Applications | grep -E "(Cursor|iTerm|Docker|Postman|Rectangle|Visual Studio Code)"
```

### Expected Success Rate
- **Critical (must succeed):** install-homebrew.sh = 100%
- **Core installations:** 90-95% success rate
- **GUI applications:** 70-80% success rate (varies by system)
- **Configuration:** 80-90% success rate

## Idempotency Guarantees

All scripts check before installing:
- `brew list <package>` - checks if already installed
- `[ -d ~/.oh-my-zsh ]` - checks if Oh My Zsh exists
- `git config --global user.name` - checks if Git configured
- `[ -f ~/.ssh/id_ed25519 ]` - checks if SSH key exists

Safe to run multiple times:
```bash
# Run again after failures - only missing items will install
./install/install.sh
```

## Performance Notes

- **Phase 1:** ~5-15 minutes (includes large Xcode CLT download)
- **Phase 2:** ~10-30 minutes (depends on network and package count)
- **Phase 3:** ~2-5 minutes (mostly configuration)
- **Total:** ~20-50 minutes for fresh installation

Parallel execution (Phase 2) can reduce time by ~40-50%.
