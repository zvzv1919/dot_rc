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
├── install/                # Modular installation scripts
│   ├── common.sh           # Shared utilities (colors, helpers)
│   ├── install.sh          # Main orchestrator
│   ├── install-homebrew.sh
│   ├── install-cli-tools.sh
│   ├── install-languages.sh
│   ├── install-apps.sh
│   ├── setup-zsh.sh
│   ├── setup-git.sh
│   ├── setup-python.sh
│   ├── setup-ssh.sh
│   └── setup-macos.sh
├── config/                 # Configuration files and migration tools
│   ├── migrate-export.sh   # Export configs/creds for laptop migration
│   ├── migrate-import.sh   # Import and apply configs on new laptop
│   └── migration.md        # Migration inventory and agent instructions
├── other/                  # Miscellaneous files and utilities
├── CLAUDE.md               # Guidance for Claude Code / AI agents
└── README.md               # This file
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

The `config/` directory contains migration scripts and documentation for transferring configs and credentials to a new laptop:

- **`migrate-export.sh`** — Run on the old laptop to bundle configs/creds and a Homebrew Brewfile into `~/Desktop/laptop-migration/`
- **`migrate-import.sh`** — Run on the new laptop to extract and apply each config independently, with a final success/failure report
- **`migration.md`** — Full inventory of what's in the migration archive, apply instructions, and guidance for AI agents

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

## Laptop Migration

To migrate configs and credentials to a new laptop:

```bash
# On the old laptop — creates ~/Desktop/laptop-migration/
./config/migrate-export.sh

# Transfer the folder to the new laptop (AirDrop, USB, etc.)

# On the new laptop — install tools first, then import configs
./install/install.sh
./config/migrate-import.sh
```

The import script applies each item independently and prints a final report of what succeeded and what failed. See [config/migration.md](config/migration.md) for the full inventory of migrated files (SSH keys, AWS/Kube/Docker/GH CLI configs, shell history, Cursor and iTerm2 settings, Homebrew packages).

## Maintenance

### Update Installed Tools
```bash
brew update && brew upgrade
```

### Backup Your Configurations
```bash
# Export all configs/creds for migration
./config/migrate-export.sh
```

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
