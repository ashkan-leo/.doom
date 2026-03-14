---
name: doom-sync
description: Run doom sync after config changes and diagnose any errors
argument-hint: "[-- flags]"
allowed-tools: Bash, Read, Grep
---

Run `doom sync` to apply pending config changes and handle the output.

## Steps

1. Run doom sync:
   ```
   ~/.config/emacs/bin/doom sync $ARGUMENTS 2>&1
   ```

2. Inspect the output:
   - **"Packages installed"** / **"Packages removed"** lines → success, summarize what changed
   - **"Error"** or **"Warning"** lines → diagnose (see below)
   - **"No changes detected"** → nothing needed, confirm to user

3. On error, check:
   - Package name typo in `packages.el`? Grep config.org and packages.el for the package name.
   - Missing `:recipe` for non-MELPA packages?
   - Module flag mismatch in `init.el` vs `config.org` usage?
   - Run `doom doctor` to surface environment issues: `~/.config/emacs/bin/doom doctor 2>&1 | head -80`

4. After a successful sync, remind the user to:
   - Restart Emacs **or** run `M-x doom/reload` inside Emacs
   - If byte-compile errors appear, try `doom sync --rebuild`

## Key paths
- Doom binary: `~/.config/emacs/bin/doom`
- Logs: `~/.config/emacs/.local/straight/build-*/`
- Native-comp cache: `~/.config/emacs/eln-cache/`
