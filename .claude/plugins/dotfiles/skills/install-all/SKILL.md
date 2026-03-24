---
name: install-all
description: Install complete macOS development environment including Homebrew, CLI tools, programming languages, GUI applications, and configurations.
version: 1.0.0
---

# Install All

Install complete macOS development environment.

## Execute

Interactive mode:
```bash
./install/install.sh
```

Automated/non-interactive mode:
```bash
./install/install-homebrew.sh && \
  ./install/install-cli-tools.sh && \
  ./install/install-languages.sh && \
  ./install/install-apps.sh && \
  ./install/setup-zsh.sh && \
  ./install/setup-python.sh && \
  ./install/setup-macos.sh
```

## Details

See `install/README.md` for complete inventory and failure handling instructions.
