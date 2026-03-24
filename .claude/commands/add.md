Add items to the dotfiles installation scripts.

The user will provide a list of tools, apps, languages, or packages to add. For each item:

1. **Identify the correct Homebrew name**: Run `brew search --cask <item>` and `brew search <item>` to find the exact package/cask name. If ambiguous, ask the user to confirm.

2. **Categorize each item** into one of these scripts:
   - `install/install-cli-tools.sh` → CLI_TOOLS array (Homebrew formulae: command-line tools)
   - `install/install-languages.sh` → LANGUAGES array (Homebrew formulae: programming languages/runtimes)
   - `install/install-apps.sh` → CASKS array (Homebrew casks: GUI applications)
   - `install/setup-python.sh` → pip3 install line (Python packages)

3. **Present a summary table** to the user before making changes:
   - Show each item, its verified Homebrew name, the target script, and a short description
   - Flag any items that are already present in a script
   - Flag any items that could not be found in Homebrew
   - Ask the user to confirm before proceeding

4. **Apply changes** after confirmation:
   - Add each item to the appropriate array in the correct script, with an inline comment describing it
   - Maintain the existing formatting style (4-space indent, inline comment with `#`)
   - Skip items already present
   - **Update `install/README.md`**: Add each new item under the appropriate section, matching the existing heading structure. Create a new subsection if needed.

User input: $ARGUMENTS
