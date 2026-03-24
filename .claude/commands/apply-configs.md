Apply configuration files from `config/` to the system.

## Instructions

1. **Zsh config**: Copy `config/.zshrc` to `~/.zshrc`. Before overwriting, check if `~/.zshrc` already exists and show a diff if it differs. Ask the user to confirm before overwriting. After copying, remind the user to run `source ~/.zshrc` or restart their terminal.

2. **iTerm2 config**: Try these approaches in order until one works:
   - First try: `open "config/iTerm2 State.itermexport"` (opens iTerm2 import dialog)
   - If that fails (e.g. iTerm2 not installed or file type not recognized): try `open -a iTerm "config/iTerm2 State.itermexport"`
   - If that also fails: copy the file to iTerm2's preferences directory manually (`cp "config/iTerm2 State.itermexport" ~/Library/Application\ Support/iTerm2/`)
   - If all automated methods fail: give the user manual instructions (open iTerm2 → Preferences → General → Import)

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
