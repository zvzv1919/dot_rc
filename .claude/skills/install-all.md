# install-all

Install complete macOS development environment (Homebrew, CLI tools, languages, apps, configs).

## Execute

```bash
./install/install.sh
```

Or for automated/non-interactive mode:

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

See `install/README.md` for inventory and failure handling.
