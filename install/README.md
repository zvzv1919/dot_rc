# Installation Inventory

Complete list of everything that will be installed by the scripts in this directory.

## Prerequisites

- **Xcode Command Line Tools** (`install-homebrew.sh`)
- **Homebrew** (`install-homebrew.sh`)
  - Configured for both Intel and Apple Silicon (ARM64)

## CLI Tools (`install-cli-tools.sh`)

### Version Control
- git
- gh (GitHub CLI)

### Utilities
- wget
- curl
- tree
- jq (JSON processor)
- htop (process viewer)
- vim
- tmux

### Modern CLI Alternatives
- ripgrep (fast grep)
- fzf (fuzzy finder)
- bat (better cat)
- eza (better ls)

### Security
- gnupg
- openssl

### Kubernetes Tools
- kubectl
- k9s (TUI)
- kind (Kubernetes in Docker)

## Programming Languages (`install-languages.sh`)

- **Python 3.12** (via Homebrew)
- **Node.js** (includes npm)
- **Go**
- **Rust**

## Python Packages (`setup-python.sh`)

- pip (upgraded to latest)
- virtualenv
- ipython
- jupyter
- numpy
- pandas
- matplotlib
- requests

## GUI Applications (`install-apps.sh`)

### Code Editors
- Visual Studio Code
- Cursor

### Terminal
- iTerm2

### Development Tools
- Docker
- Postman (API testing)
- Rectangle (window management)

## Shell Configuration (`setup-zsh.sh`)

- Oh My Zsh framework
- zsh-autosuggestions plugin
- zsh-syntax-highlighting plugin

## Git Configuration (`setup-git.sh`)

- user.name (interactive prompt)
- user.email (interactive prompt)
- init.defaultBranch = main
- pull.rebase = false
- core.editor = vim

## SSH Key (`setup-ssh.sh`)

- ED25519 key pair at `~/.ssh/id_ed25519`
- Added to SSH agent

## macOS Preferences (`setup-macos.sh`)

### Finder
- AppleShowAllFiles = true
- ShowPathbar = true
- ShowStatusBar = true

### System
- LSQuarantine = false (disable quarantine dialog)
- ApplePressAndHoldEnabled = false (enable key repeat)
- KeyRepeat = 2
- InitialKeyRepeat = 15
- Screenshot location = ~/Screenshots

## Failure Handling

### General Principles
1. **Continue on failure**: Skip failed sections and proceed to next
2. **Record all failures**: Log script name, error message, and timestamp
3. **Do not retry**: Avoid retry loops that may hang the process
4. **No prompts on failure**: Interactive prompts should be skipped if they fail

### Common Failure Scenarios

#### Homebrew Installation Failures
- **Command Line Tools not installed**: Script will prompt to install and exit (requires user action)
- **Homebrew install fails**: Skip all Homebrew-dependent scripts
- **Individual package fails**: Record failure, continue with remaining packages

#### Cask Installation Failures
- **Application requires Rosetta on M1**: May fail, record and skip
- **License agreement required**: May fail, record and skip
- **Download timeout**: Record and skip

#### Git Configuration Failures
- **Missing user input**: Skip if running non-interactively
- **Invalid email format**: Record and continue

#### SSH Key Generation Failures
- **Key already exists**: Not a failure, skip generation
- **Missing email**: Skip if running non-interactively
- **ssh-agent not running**: Record failure, skip adding to agent

#### Oh My Zsh Failures
- **Already installed**: Not a failure, skip installation
- **Git clone timeout**: Record and skip
- **Plugin clone fails**: Record which plugin failed, continue

#### Python Package Failures
- **pip not found**: Ensure Python was installed first
- **Package conflict**: Record which package failed, continue with others
- **Network timeout**: Record and skip

### Failure Log Format

```
FAILURE: <script_name>
Timestamp: <ISO 8601>
Error: <error message>
Action: Skipped and continued
---
```

### Recovery

All scripts are idempotent. After resolving issues, re-run failed scripts individually:
```bash
./install/<failed-script>.sh
```
