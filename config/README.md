# Configuration and Migration

This directory contains migration scripts for transferring configs and credentials to a new macOS laptop.

## Laptop Migration

### `migrate-export.sh`
Run on the **old laptop** to bundle configs, credentials, and a Homebrew Brewfile into `~/Desktop/laptop-migration/`.

```bash
./config/migrate-export.sh
```

### `migrate-import.sh`
Run on the **new laptop** to extract and apply each config item independently. Prints a final success/failure report.

```bash
./config/migrate-import.sh                # reads from ~/Desktop/laptop-migration/
./config/migrate-import.sh /path/to/dir   # or specify a custom location
```

### `migration.md`
Full inventory of every file in the migration archive, including:
- Source and destination paths
- Notes on each item (permissions, rotation advice, etc.)
- Instructions for AI agents on how to apply configs independently

See [migration.md](migration.md) for the complete reference.

## What Gets Migrated

| Category | Items |
|----------|-------|
| Credentials | SSH keys, AWS config, Kubernetes config, GitHub CLI auth, Docker config |
| Shell & Git | `.zshrc`, `.gitconfig`, `.zsh_history`, `z` database |
| Dev Tools | Cursor settings/keybindings, iTerm2 preferences |
| Packages | Homebrew Brewfile (formulas + casks) |

## Notes

- Always transfer the migration archive securely (AirDrop, USB, encrypted transfer)
- Run `./install/install.sh` on the new laptop **before** importing configs
- The import script backs up existing files before overwriting
- Review the final report and manually address any failures
