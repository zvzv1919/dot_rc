Apply configuration files from `config/` to the system.

## Instructions

1. **Zsh config**: Copy `config/.zshrc` to `~/.zshrc`. Before overwriting, check if `~/.zshrc` already exists and show a diff if it differs. Ask the user to confirm before overwriting. After copying, remind the user to run `source ~/.zshrc` or restart their terminal.

2. **iTerm2 config**: The export file (`config/iTerm2 State.itermexport`) is a tar.gz archive containing `user-defaults/UserDefaults.plist`, `app-support/`, and `dot-iterm2/` (shell integration scripts). Apply via direct copy:
   - Extract the archive to a temp directory: `tar -xzf "config/iTerm2 State.itermexport" -C /tmp/iterm_extract`
   - Warn the user that iTerm2 must be quit before applying (it overwrites prefs on exit). If running inside iTerm2, start a tmux session first so the shell survives.
   - Quit iTerm2: `osascript -e 'tell application "iTerm2" to quit'` and wait a few seconds.
   - Copy `user-defaults/UserDefaults.plist` → `~/Library/Preferences/com.googlecode.iterm2.plist`
   - Copy `app-support/*` → `~/Library/Application Support/iTerm2/`
   - Copy `dot-iterm2/*` → `~/.iterm2/`
   - Relaunch iTerm2: `open -a iTerm`

3. **Cursor profile**: The file `config/default_cursor_profile.code-profile` is a JSON bundle with double-encoded inner fields. To apply it programmatically:

   a. Parse the JSON file. It has keys: `name`, `settings`, `keybindings`, `extensions`, `globalState`.
   b. Extract and decode `settings` → inner key `settings` (a JSON string of the actual settings object).
   c. Extract and decode `keybindings` → inner key `keybindings` (a JSONC string).
   d. Extract and decode `extensions` (a JSON array of extension identifiers).

   Write the decoded values to Cursor's config directory at `~/Library/Application Support/Cursor/User/`:
   - `settings.json` — the decoded settings object
   - `keybindings.json` — the decoded keybindings array

   For extensions, install each one using: `cursor --install-extension <id>` (or if `cursor` CLI is not available, fall back to telling the user to install them manually).

   Before overwriting any file, show a diff and ask the user to confirm. Warn the user to close Cursor first to avoid conflicts.

## Reference

See `config/README.md` for detailed instructions and customization options.
