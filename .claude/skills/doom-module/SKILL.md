---
name: doom-module
description: Look up a Doom Emacs module's documentation, flags, and packages before configuring anything manually. Use this when the user asks about adding a feature, package, or integration to Doom.
argument-hint: "<feature or module name, e.g. 'llm', 'lsp', 'tree-sitter'>"
allowed-tools: Read, Grep, Bash
---

Before suggesting manual package config, always check if Doom already has a module for it.

## Module location

Doom modules live at:
```
~/.config/emacs/modules/<category>/<module>/
```

Categories: `app`, `checkers`, `completion`, `config`, `editor`, `emacs`, `email`, `input`, `lang`, `os`, `term`, `themes`, `tools`, `ui`

Each module contains:
- `README.org` — description, flags, packages, keybinds, configuration
- `packages.el` — packages the module installs
- `config.el` — default configuration
- `init.el` — module init (if any)

## Steps

### 1. Find the module

Search for the topic across all module READMEs:
```bash
grep -rl "$ARGUMENTS" ~/.config/emacs/modules/*/*/README.org
```

Also search module directory names:
```bash
ls ~/.config/emacs/modules/*/ | grep -i "$ARGUMENTS"
```

### 2. Read the README

Read `README.org` for the matched module. Extract:
- **Description** — what it does
- **Module flags** — optional `+flags` that change behaviour
- **Packages** — what gets installed
- **Keybinds** — what keybinds are set up
- **Configuration** — what vars/functions to customize

### 3. Check if it's enabled in init.el

```
Grep ~/.config/doom/init.el for the module name
```

Report whether it's already enabled, disabled, or missing.

### 4. Check existing user config

```
Grep ~/.config/doom/config.org for the module's packages/vars
```

### 5. Report

Return:
- **Module path:** e.g. `tools/llm`
- **Enabled:** yes/no (and with which flags)
- **What it provides:** packages, keybinds, key vars
- **Recommended action:** enable the module in `init.el` with appropriate flags, OR configure manually if no module exists

## Key rule

**Always prefer enabling a Doom module over manually declaring packages.** Doom modules handle pinning, byte-compilation, and integration. Only fall back to `packages.el` if no module covers the need.
