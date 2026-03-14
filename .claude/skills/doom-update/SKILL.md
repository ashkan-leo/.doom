---
name: doom-update
description: Update doom emacs and/or packages — runs doom upgrade, handles errors, summarizes what changed
argument-hint: "[--packages-only | --doom-only]"
allowed-tools: Bash, Read, Grep
---

Update doom emacs core and/or installed packages.

## Steps

### 1. Determine scope

- No argument / default → full update: doom core + all packages (`doom upgrade`)
- `--packages-only` → skip doom core, only update pinned/unpinned packages (`doom sync -u`)
- `--doom-only` → pull doom core repo only, then sync

### 2. Snapshot current state before updating
```bash
~/.config/emacs/bin/doom info 2>&1 | grep -E "Doom|Emacs version"
git -C ~/.config/emacs log --oneline -1
```

### 3. Run the update

**Full upgrade (default):**
```bash
~/.config/emacs/bin/doom upgrade 2>&1
```

**Packages only:**
```bash
~/.config/emacs/bin/doom sync -u 2>&1
```

### 4. Interpret the output

- **"X packages updated"** → success, list which packages changed
- **"Already up to date"** → nothing to do
- **Error during build/compile** → see troubleshooting below
- **Native-comp warnings** → usually safe to ignore unless functionality breaks

### 5. Troubleshooting update errors

| Error | Fix |
|---|---|
| Byte-compile error on a package | `doom sync --rebuild` to force recompile |
| Straight.el lock conflict | `doom sync --force` |
| Stale native-comp cache | `rm -rf ~/.config/emacs/eln-cache && doom sync` |
| Package removed from MELPA | Pin it in `packages.el` with `:pin "last-good-sha"` or `:recipe (:host github ...)` |
| Doom core update broke something | `git -C ~/.config/emacs log --oneline -20` to see what changed; check doom's changelog |

### 6. Check for breaking changes

After a doom core update, check for release notes:
```bash
git -C ~/.config/emacs log --oneline ORIG_HEAD..HEAD 2>/dev/null | head -20
```

Flag any commits mentioning "breaking", "removed", or "deprecated" to the user.

### 7. Finish

Remind the user to:
- Restart Emacs fully (not just `doom/reload`) after a core update
- Run `M-x doom/reload` inside Emacs after a packages-only update
- Check `*Warnings*` buffer on next startup for any new issues
