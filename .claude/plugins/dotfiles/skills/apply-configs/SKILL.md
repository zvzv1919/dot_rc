---
name: apply-configs
description: Apply stored configuration files (zsh, iTerm2, Cursor) to the system.
version: 1.0.0
---

# Apply Configs

Apply stored configuration files to the system.

## Execute

```bash
# Zsh configuration
cp config/.zshrc ~/.zshrc && source ~/.zshrc

# iTerm2 configuration
open "config/iTerm2 State.itermexport"
```

Cursor profile must be imported manually via Settings → Profiles → Import → `config/default_cursor_profile.code-profile`

## Details

See `config/README.md` for full instructions.
