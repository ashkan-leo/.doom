---
name: add-package
description: Add a new Emacs package to this doom config — packages.el declaration, config.org section, and doom sync
argument-hint: "<package-name> [description of what you want it to do]"
allowed-tools: Read, Edit, Grep, Bash
---

Full workflow to add a new package to this doom emacs config.

## Context
- **Do NOT edit `config.el`** — it is auto-generated. All config goes in `config.org`.
- Namespace prefix for custom vars/functions: `pipboy/`
- Doom binary: `~/.config/emacs/bin/doom`

## Steps

### 1. Check if a Doom module already provides it

**Always check this first** — prefer enabling a module over a manual `package!`.

```bash
grep -rl "$0" ~/.config/emacs/modules/*/*/README.org
ls ~/.config/emacs/modules/*/ | grep -i "$0"
```

If a module exists, use the `doom-module` skill to read its README and enable it in `init.el` instead of proceeding here.

Also grep `packages.el` and `init.el` to check if it's already declared:

```
Grep packages.el and init.el for: $0
```

### 2. Add the package declaration to `packages.el`

Append a `(package! ...)` form. Use the simplest form that works:

```elisp
;; From MELPA (most packages):
(package! package-name)

;; Pinned to a commit:
(package! package-name :pin "COMMIT-SHA")

;; From a git repo not on MELPA:
(package! package-name
  :recipe (:host github :repo "user/repo"))

;; Disabled (override doom default):
(package! package-name :disable t)
```

### 3. Add configuration to `config.org`

Find the appropriate section heading (UI, Languages, Tools, Workflows, etc.) and insert a new subheading.

**Documentation is required** — every section must include prose above the source block:

```org
** Package Name
One sentence: what this package does and why it's here.

Link to upstream if non-obvious: [[https://github.com/user/repo][package-name]]

Requirements (env vars, external tools, first-run steps) if any.

| Key       | Action        |
|-----------+---------------|
| =SPC x y= | does the thing |

#+begin_src emacs-lisp
(use-package! package-name
  :after some-dep          ;; if needed
  :config
  (setq package-name-option value)) ;; comment only if non-obvious WHY
#+end_src
```

Conventions:
- Use `use-package!` (doom's version), not plain `use-package`
- Defer loading with `:defer t` or `:after` when possible
- Keybindings go inside `:config` using `(map! ...)` or as a separate `map!` block
- Inline comments only for non-obvious logic — not narrating every line

### 4. Run doom sync

Use the `doom-sync` skill or run:
```
~/.config/emacs/bin/doom sync 2>&1
```

### 5. Verify
- Confirm no errors in sync output
- Remind user to `M-x doom/reload` or restart Emacs
- Summarize what was added and where in config.org
