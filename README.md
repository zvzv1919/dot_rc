# macOS Development Environment Dotfiles

A modular collection of scripts and configuration files to bootstrap and maintain a macOS development environment.

## Quick Start

```bash
# Clone the repository
git clone <repository-url> ~/dotfiles
cd ~/dotfiles

# Run the main installation script
./install/install.sh
```

## Project Structure

```
.
├── skills/           # Executable skills for automated installation
├── install/          # Installation scripts for tools and apps
├── config/           # Configuration files for various applications
├── other/            # Miscellaneous files and utilities
├── CLAUDE.md         # Documentation for Claude Code
└── README.md         # This file
```

## Installation

### Automated Setup

The `install/` directory contains modular scripts for setting up your environment:

1. **Run the complete setup:**
   ```bash
   ./install/install.sh
   ```
   This installs all tools and prompts for optional configurations.

2. **Or run individual scripts:**
   ```bash
   ./install/install-homebrew.sh      # Install Homebrew
   ./install/install-cli-tools.sh     # Install CLI tools
   ./install/install-languages.sh     # Install programming languages
   ./install/install-apps.sh          # Install GUI applications
   ./install/setup-zsh.sh             # Setup Oh My Zsh
   ./install/setup-git.sh             # Configure Git
   ./install/setup-python.sh          # Install Python packages
   ./install/setup-ssh.sh             # Generate SSH key
   ./install/setup-macos.sh           # Apply macOS preferences
   ```

See [install/README.md](install/README.md) for detailed documentation.

## Configuration

The `config/` directory contains configuration files:

- **`.zshrc`** - Zsh configuration with Oh My Zsh
- **`default_cursor_profile.code-profile`** - Cursor editor profile
- **`iTerm2 State.itermexport`** - iTerm2 terminal configuration

### Applying Configurations

```bash
# Zsh configuration
cp config/.zshrc ~/.zshrc
source ~/.zshrc

# iTerm2 (import via Preferences or open the file)
open "config/iTerm2 State.itermexport"

# Cursor (import via Settings → Profiles)
```

See [config/README.md](config/README.md) for detailed documentation.

## What Gets Installed

### CLI Tools
git, wget, curl, tree, jq, htop, vim, tmux, ripgrep, fzf, bat, eza, gh, gnupg, kubectl, k9s, kind, openssl

### Programming Languages
Python 3.12, Node.js, Go, Rust

### GUI Applications
Visual Studio Code, Cursor, iTerm2, Docker, Postman, Rectangle

### Shell
Oh My Zsh with plugins: z, zsh-autosuggestions, zsh-syntax-highlighting

See [install/README.md](install/README.md) for the complete list and customization options.

## Customization

### Adding New Tools

Edit the arrays in the installation scripts:
- CLI tools: `install/install-cli-tools.sh` → `CLI_TOOLS` array
- Languages: `install/install-languages.sh` → `LANGUAGES` array
- Applications: `install/install-apps.sh` → `CASKS` array

### Modifying Configurations

1. Edit the config files in `config/`
2. Copy them to your home directory or import them into the application
3. Commit changes to track your preferences

## Maintenance

### Update Installed Tools
```bash
brew update && brew upgrade
```

### Backup Your Configurations
```bash
# Backup Zsh config
cp ~/.zshrc config/.zshrc

# Export iTerm2 settings
# Preferences → General → Preferences → Save Current Settings

# Export Cursor profile
# Settings → Profiles → Export Profile
```

## Automated Execution

For automated installation (bots, CI/CD, Claude Code):
```bash
# See skills/install-all.md for complete automation instructions
```

The `skills/` directory contains executable skills with proper failure handling:
- Continue on failure, don't stop
- Log all results
- No retry loops
- Validate installations

## Notes

- All installation scripts are idempotent (safe to run multiple times)
- Scripts check for existing installations before attempting to install

## Additional Manual Configuration

### iTerm2
- Preferences → Advanced → "Scroll wheel sends arrow keys in alternate screen mode" (useful for k9s)

### VS Code
- Install Monokai Pro theme: Extensions → Search for "Monokai Pro"

## Requirements

- macOS (tested on recent versions)
- Internet connection for downloading tools
- Administrative privileges for some installations

## License

This is a personal dotfiles repository. Feel free to use and modify as needed.
