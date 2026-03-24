# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a modular dotfiles/configuration repository for bootstrapping and maintaining macOS development environments. It contains installation scripts and configuration files organized into logical sections.

## Project Structure

```
install/           # Modular installation scripts
config/            # Configuration files (zshrc, iTerm2, Cursor)
.claude/commands/  # Claude Code slash commands (invoke via /project:<name>)
other/             # Miscellaneous files
```

## Installation Scripts (install/)

### Main Script
Run `./install/install.sh` to orchestrate the full setup. It executes scripts in order and prompts for optional configurations.

### Core Installation Scripts
All scripts source `install/common.sh` for shared functions and are idempotent (safe to run multiple times).

**`install/common.sh`** - Shared utilities:
- Color output functions: `echo_info`, `echo_success`, `echo_warning`, `echo_error`
- Helper functions: `check_macos()`, `ensure_homebrew()`
- All scripts exit on error (`set -e`)

**`install/install-homebrew.sh`** - Installs Homebrew and Command Line Tools. Handles both Intel and Apple Silicon Macs (ARM64 detection for brew path).

**`install/install-cli-tools.sh`** - Installs CLI tools via Homebrew. Edit `CLI_TOOLS` array to add new tools.

**`install/install-languages.sh`** - Installs programming languages (Python, Node.js, Go, Rust). Edit `LANGUAGES` array to add more.

**`install/install-apps.sh`** - Installs GUI applications via Homebrew Casks. Edit `CASKS` array to add applications.

**`install/setup-zsh.sh`** - Installs Oh My Zsh and plugins (zsh-autosuggestions, zsh-syntax-highlighting).

**`install/setup-git.sh`** - Interactive Git configuration (user.name, user.email, defaults).

**`install/setup-python.sh`** - Installs common Python packages via pip3.

**`install/setup-ssh.sh`** - Interactive SSH key generation for GitHub (ED25519).

**`install/setup-macos.sh`** - Applies macOS system preferences (Finder settings, keyboard repeat, etc.).

### Adding New Tools
1. Edit the appropriate array in the script (CLI_TOOLS, LANGUAGES, or CASKS)
2. Run the script - it skips already-installed items
3. All scripts use Homebrew; check if package exists first

## Configuration Files (config/)

**`config/.zshrc`** - Oh My Zsh configuration:
- Theme: `avit`
- Plugins: `z`, `zsh-autosuggestions`
- Includes nvm setup and iTerm2 shell integration
- Copy to `~/.zshrc` and run `source ~/.zshrc` to apply

**`config/default_cursor_profile.code-profile`** - Cursor editor profile (import via Settings → Profiles)

**`config/iTerm2 State.itermexport`** - Complete iTerm2 configuration (import via Preferences or `open` command)

## Slash Commands

Custom Claude Code commands live in `.claude/commands/` and are invoked as `/project:<name>`:

- `/project:install` - Install macOS dev environment (presents module selection, runs scripts in phases)
- `/project:apply-configs` - Apply configuration files from `config/` to the system

Each command file contains instructions for Claude to execute the task.

## Common Development Tasks

### Full setup on new machine
```bash
./install/install.sh
```

### Install specific components
```bash
./install/install-cli-tools.sh
./install/install-languages.sh
./install/install-apps.sh
```

### Update configurations
```bash
cp config/.zshrc ~/.zshrc && source ~/.zshrc
```

### Add a new CLI tool
Edit `install/install-cli-tools.sh`, add to `CLI_TOOLS` array, run the script.

### Update Homebrew packages
```bash
brew update && brew upgrade
```

## Command Maintenance

When an exploration or user-involved interaction discovers a working approach for a task (e.g. figuring out how to apply a config file), always update the relevant `.claude/commands/*.md` file with the working approach. This ensures future runs of the command use the proven method automatically rather than re-discovering it.

## Architecture Notes

- All installation scripts are modular and can run independently (except install-homebrew.sh must run first)
- Scripts check for existing installations before attempting installation
- Common functions centralized in `install/common.sh`
- Both Intel and Apple Silicon Macs supported
- Scripts are designed to be non-destructive and interruptible
