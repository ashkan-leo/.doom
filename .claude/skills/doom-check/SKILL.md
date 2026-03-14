---
name: doom-check
description: Run static analysis and byte-compile checks on the Doom config without opening Emacs
argument-hint: "[--static-only] [--byte-compile-only]"
allowed-tools: Bash
---

Run the doom-check script to validate the config before or after making changes.

## Key files

| File | Purpose |
|------|---------|
| `~/.config/doom/bin/doom-check` | Executable check script — **edit this to add checks** |
| `~/.config/doom/tests/config-tests.el` | ERT test suite — **edit this to add tests** |

## Usage

```bash
~/.config/doom/bin/doom-check                    # full check (static + ERT + byte-compile)
~/.config/doom/bin/doom-check --static-only      # fast grep checks only
~/.config/doom/bin/doom-check --byte-compile-only
```

## What it checks

### Static analysis (config.org + config.el)
- `setq!` obsolete macro (Doom 3.0 → use `setopt`)
- `(require 'cl)` deprecated (use `cl-lib`)
- `:background nil` invalid face attribute (use `'unspecified`)
- Minor mode called with `t` arg (e.g. `(foo-mode t)` → use hook or `+1`)
- `defun` inside `after!` block (not byte-compiled)
- `:ensure t` in use-package! (wrong for Doom/straight.el)
- Obsolete `dap-mode` references (Doom uses `dape` now)
- `config.el` freshness relative to `config.org`

### Byte-compile (config.el)
- Loads Doom's environment, then runs `batch-byte-compile` on config.el
- Catches: undefined functions, wrong call signatures, missing requires

## When to run

- **Before opening Emacs** after editing config.org — catches issues before the cycle
- **After making any config change** — confirm no new problems introduced
- **When debugging a warning** — static checks often reveal the source immediately

## Extending

Add new shell checks to `~/.config/doom/bin/doom-check`.
Add new functional tests to `~/.config/doom/tests/config-tests.el`.

Shell check pattern:

```bash
count=$(grep -c 'pattern' "$CONFIG_ORG" 2>/dev/null || true)
[[ $count -gt 0 ]] && fail "description" || ok "description"
```
