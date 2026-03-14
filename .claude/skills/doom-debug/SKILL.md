---
name: doom-debug
description: Systematically debug a doom emacs issue — errors, broken packages, slow startup, keybinding conflicts
argument-hint: "<description of the issue>"
allowed-tools: Read, Grep, Bash
---

Systematically diagnose and fix a doom emacs issue.

## Issue reported
$ARGUMENTS

## Diagnostic Steps (run in order, stop when root cause found)

### 1. Reproduce in clean environment
Ask the user: does the issue appear with `emacs --init-directory ~/.config/emacs -q`?
- **Yes** → doom core issue, not user config
- **No** → user config (`config.org`) is the cause → proceed to step 3

### 2. Run doom doctor
```bash
~/.config/emacs/bin/doom doctor 2>&1 | grep -E "(✗|Warning|Error)" | head -40
```
Fix any reported issues first.

### 3. Check recent changes
```bash
git -C ~/.config/doom log --oneline -10
git -C ~/.config/doom diff HEAD~1 -- config.org packages.el init.el
```
Correlate the issue onset with recent commits.

### 4. Search config.org for the relevant config
Grep `config.org` for the package/feature name mentioned in the issue. Read surrounding context.

### 5. Check for byte-compile errors
```bash
~/.config/emacs/bin/doom sync --rebuild 2>&1 | grep -i "error\|warning" | head -30
```

### 6. Check Emacs messages / warnings
Ask user to run inside Emacs:
- `M-x view-echo-area-messages` — recent messages
- `*Messages*` buffer — startup output
- `*Warnings*` buffer — non-fatal issues

### 7. Locate the error source
If there's a backtrace or error message, grep `config.org` and installed package sources:
```bash
find ~/.config/emacs/.local/straight/repos -name "*.el" | xargs grep -l "SYMBOL" 2>/dev/null | head -10
```

### 8. Common fixes by symptom

| Symptom | Likely cause | Fix |
|---------|-------------|-----|
| `Symbol's function definition is void` | package not loaded yet | Add `:defer nil` or `(after! pkg ...)` |
| Keybinding not working | wrong keymap or evil state | Check `map!` evil state flag (`:n`, `:i`, etc.) |
| Package not found after sync | typo or wrong `:recipe` | Check `packages.el` |
| Slow startup | too many `:demand t` or no `:defer` | Profile with `M-x esup` |
| `Wrong type argument` | config loaded before package | Wrap in `(after! package ...)` |
| Native comp warnings | stale eln cache | `rm -rf ~/.config/emacs/eln-cache && doom sync` |

## Reporting back
After diagnosis:
1. State the root cause clearly
2. Show the specific config.org location (heading path) where the fix goes
3. Make the minimal change needed — do not refactor surrounding code
