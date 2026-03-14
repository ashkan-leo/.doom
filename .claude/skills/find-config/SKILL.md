---
name: find-config
description: Find where something is configured in config.org, or determine the right place to add new config
argument-hint: "<package, feature, or keybinding to find>"
allowed-tools: Read, Grep
---

Locate existing configuration or identify the correct insertion point for new config.

## What to find
$ARGUMENTS

## Steps

### 1. Search config.org for the topic
Grep `config.org` for the package/feature name (case-insensitive):

```
Grep config.org for: $ARGUMENTS
```

Also try related terms: the mode name, the command name, or the keybinding prefix.

### 2. Identify the org heading path

Report results as a heading breadcrumb trail, e.g.:
```
* Tools > ** LSP > *** Python (line 842)
```

Show the relevant `#+begin_src emacs-lisp` block and surrounding org text.

### 3. If not found — suggest the right section

Use this section map to recommend where new config belongs:

| Content type | Recommended heading |
|---|---|
| Look & feel, fonts, themes, modeline | `* UI` |
| Terminal, vterm, eshell, tmux | `* Terminal` |
| Org-mode, GTD, roam, agenda | `* Workflows > ** Org` |
| A programming language or LSP | `* Languages > ** <Language>` |
| Editor behaviour, evil, snippets | `* Editor` |
| External tools (docker, git, etc.) | `* Tools` |
| OS-specific tweaks | `* OS` |
| Keybindings (global or misc) | Bottom of relevant section |

### 4. For keybindings specifically

Search for existing `map!` usage for the relevant mode:
```
Grep config.org for: map!.*<mode-or-prefix>
```

Doom `map!` syntax reference:
```elisp
;; Global (normal state by default)
(map! "C-x f" #'my-function)

;; Leader key (SPC)
(map! :leader
      :desc "Description" "k k" #'my-function)

;; Mode-local
(map! :map org-mode-map
      :n "C-c t" #'org-todo)

;; Evil state flags: :n normal, :i insert, :v visual, :m motion, :o operator
```

### 5. Report format

Always return:
- **File:** `config.org`
- **Heading path:** e.g., `* Tools > ** Magit`
- **Line number:** approximate
- **Snippet:** the relevant block
- **Recommendation:** what to do / where to insert
