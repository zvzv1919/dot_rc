# Configuration Files

This directory contains configuration files and profiles for various development tools.

## Files

### `.zshrc`
Zsh shell configuration using Oh My Zsh framework.

**Features:**
- Theme: `avit`
- Plugins: `z` (directory jumper), `zsh-autosuggestions`
- Includes nvm (Node Version Manager) setup
- iTerm2 shell integration support

**Installation:**
```bash
cp .zshrc ~/.zshrc
source ~/.zshrc
```

**Customization:**
- Change theme: Edit `ZSH_THEME` variable
- Add plugins: Add to `plugins=()` array
- See [Oh My Zsh documentation](https://github.com/ohmyzsh/ohmyzsh/wiki) for options

### `default_cursor_profile.code-profile`
Cursor editor profile containing settings, extensions, and preferences.

**Installation:**
1. Open Cursor editor
2. Go to Settings → Profiles
3. Import this profile file

### `iTerm2 State.itermexport`
Complete iTerm2 terminal configuration export.

**Features:**
- Scroll wheel sends arrow keys in alternate screen mode (useful for k9s)
- Custom color schemes, fonts, and key bindings
- Window arrangements and profiles

**Installation:**
1. Open iTerm2
2. Go to Preferences → General → Preferences
3. Click "Load preferences from a custom folder or URL"
4. Select this file or the directory containing it

Alternatively:
```bash
# Import settings
open "iTerm2 State.itermexport"
```

## Additional Recommended Configurations

### VS Code
**Theme:** Install Monokai Pro extension
```
code --install-extension monokai.theme-monokai-pro-vscode
```

### Git
See `../install/setup-git.sh` for automated Git configuration.

### SSH
See `../install/setup-ssh.sh` for SSH key generation.

## Backup and Sync

To export your current configurations:

**Zsh:**
```bash
cp ~/.zshrc .zshrc
```

**iTerm2:**
1. Preferences → General → Preferences → Save Current Settings to Folder
2. Or: Profiles → Other Actions → Save All Profiles as JSON

**Cursor:**
1. Settings → Profiles → Export Profile

## Laptop Migration

Scripts and documentation for migrating configs and credentials to a new laptop:

- **`migration.md`** — Full inventory of files in the migration archive, apply instructions, and agent guidance
- **`migrate-export.sh`** — Run on the old laptop to create `~/Desktop/laptop-migration/` (tarball + Brewfile)
- **`migrate-import.sh`** — Run on the new laptop to untar and apply each config independently, with a final success/failure report

See [migration.md](migration.md) for details.

## Notes

- Always backup existing config files before overwriting
- Some configurations may need paths adjusted for your username/system
- Review configs before applying to understand what changes will be made
