Install the macOS development environment. Run each phase sequentially using the shell scripts in `install/`.

## Instructions

1. First confirm with the user which modules to install. Present this list and ask them to confirm or deselect:

   **Phase 1 - Prerequisites (required):**
   - Homebrew & Xcode CLT (`install/install-homebrew.sh`)

   **Phase 2 - Core installations:**
   - CLI tools (`install/install-cli-tools.sh`)
   - Programming languages (`install/install-languages.sh`)
   - GUI applications (`install/install-apps.sh`)
   - Oh My Zsh + plugins (`install/setup-zsh.sh`)

   **Phase 3 - Optional configuration:**
   - Git config (`install/setup-git.sh`) - interactive
   - Python packages (`install/setup-python.sh`)
   - SSH key for GitHub (`install/setup-ssh.sh`) - interactive
   - macOS preferences (`install/setup-macos.sh`)

2. Run Phase 1 first. Verify `brew --version` succeeds before continuing.

3. Run selected Phase 2 scripts **in parallel** (they are independent). Use parallel Bash tool calls or subagents. If one fails, log the error — don't block the others.

4. Run selected Phase 3 scripts **in parallel** where possible. Non-interactive scripts (setup-python.sh, setup-macos.sh) can run in parallel with each other. Interactive scripts (setup-git.sh, setup-ssh.sh) require stdin, so warn the user and run them one at a time.

5. After all scripts complete, run `brew cleanup` and report a summary of what succeeded and what failed.

## Reference

See `install/README.md` for the full inventory of packages and failure handling details. All scripts source `install/common.sh` for shared utilities and are idempotent.
