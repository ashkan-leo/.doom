# Doom Emacs Configuration

This is a personal [[https://github.com/doomemacs/doomemacs][Doom Emacs]] configuration written in literate org-mode style.

## Project Layout

| File/Dir        | Purpose                                              |
|-----------------|------------------------------------------------------|
| `config.org`    | Primary literate config — edit this, not `config.el` |
| `config.el`     | Tangled output of `config.org` — do not edit directly |
| `init.el`       | Doom module declarations                             |
| `packages.el`   | Extra package declarations (`package!` forms)        |
| `custom.el`     | Emacs `custom-set-variables` — do not edit manually  |
| `snippets/`     | YASnippet templates organized by major mode          |
| `splash/`       | Custom splash screen images                          |

## Conventions

- **All user config lives in `config.org`** as literate org-mode with elisp source blocks. After editing, run `doom sync` or tangle the file to regenerate `config.el`.
- **Namespace prefix:** user-defined variables and functions use the `pipboy/` prefix (e.g., `pipboy/org-notes`, `pipboy/gtd-directory`).
- **Deferred config** uses the `after!` macro. Prefer `after!` over `with-eval-after-load`.
- **Keybindings** use the `map!` macro with `SPC` as the leader key.
- **Do not edit** `config.el`, `custom.el` directly.

## Key Paths (runtime)

| Variable               | Path                          |
|------------------------|-------------------------------|
| `pipboy/org-notes`     | `~/w/roam/`                   |
| `pipboy/gtd-directory` | `~/w/beorg/`                  |
| Projectile root        | `~/w`                         |
| Bibliography           | `~/Dropbox/Apps/bibliography/`|

## Modules Active (init.el highlights)

- **Completion:** `company` (childframe), `vertico` (icons)
- **Editor:** `evil`, `snippets`, `multiple-cursors`, `parinfer`, `format`
- **Tools:** `lsp` (peek), `magit` (forge), `docker`, `terraform`, `direnv`, `dap`
- **Languages:** Python (pyright/poetry), Rust, Java, Scala, Haskell, JS/TS, LaTeX, Nix, Org, Prolog
- **AI:** `gptel`, `copilot`, `chatgpt-shell`
- **Org:** `org-roam`, `org-ref`, `org-super-agenda`, `org-noter`, `org-drill`

## Consulting Doom Documentation

**Before recommending or configuring any module, package, flag, or keybinding, consult the Doom source:**

- **Module READMEs:** `~/.config/emacs/modules/:category/module-name/README.org` — authoritative docs for flags, config variables, keybindings, and dependencies.
- **Module source:** `~/.config/emacs/modules/:category/module-name/config.el` (and `autoload/`, `packages.el`) — check what the module already provides before adding custom config that duplicates or conflicts.
- **Doom core:** `~/.config/emacs/lisp/` — for macros like `map!`, `after!`, `use-package!`, `package!` and core APIs.
- **Categories:** `:app`, `:checkers`, `:completion`, `:config`, `:editor`, `:emacs`, `:email`, `:input`, `:lang`, `:os`, `:term`, `:tools`, `:ui`

**Rules:**
- Never recommend a flag without verifying it exists in the module's source.
- Never assume a package needs manual installation if a Doom module already provides it.
- Check module README before suggesting config — the module may already expose a variable or flag for the behavior.
- When debugging, read the module's `config.el` to understand load order and `after!` wrapping.

## Opening Files for the User

When you reference a file the user may want to look at (to review a change, inspect a location, etc.), **open it in Emacs for them** via the `mcp__ide__executeCode` tool instead of just printing the path.

- Default: `(find-file "/absolute/path")` — opens in the current window.
- To jump to a specific line: `(progn (find-file "/abs/path") (goto-char (point-min)) (forward-line (1- LINE)))`.
- To avoid stealing focus from the Claude buffer, use `(find-file-other-window "/abs/path")`.
- Always pass absolute paths.
- Skip this for transient mentions (e.g. "I ran `git status`") — only open files the user would plausibly want to view.

## Making Changes

1. Edit `config.org` — find the relevant heading/section.
2. Add/change a `#+begin_src emacs-lisp` block.
3. To add a package: edit `packages.el` with a `(package! ...)` form.
4. To toggle a module: edit `init.el`.
5. After changes run: `doom sync` (then restart Emacs or `M-x doom/reload`).

## Documentation Standard

**Every config change must be documented in `config.org` at the point of the change.** This file is the single source of truth — someone reading it cold should understand what each section does and why.

### For each section or package, include:

- **What it is** — one sentence: package name, what it does, where it comes from (module vs manual).
- **Why it's here** — the use case or problem it solves (skip if obvious).
- **Keybindings** — a table if there are custom bindings. Include doom built-ins too if they're non-obvious.
- **Config options** — for non-default settings, a brief inline comment explaining *why* that value, not just what it is.
- **Requirements** — env vars, external tools, API keys, login steps (`M-x ...`).
- **Links** — org hyperlinks to upstream repo or docs where useful.

### Style rules:

- Prose goes **above** the `#+begin_src` block, not inside it as comments (keep code clean).
- Inline comments inside source blocks only for non-obvious logic — not narrating every line.
- Use org tables for keybindings and backend/option lists.
- No filler ("This section configures..."), no over-explaining obvious elisp.

## Org GTD Workflow

- **Keywords:** `TODO → NOW → NEXT → WAIT → SOMEDAY → HOLD → PROJECT → DONE / CANCEL`
- **Context tags:** `@work @home @business @university @travel @errand @phone @email`
- **Files:** inbox, tickler, someday, gtd, notes (all under `pipboy/gtd-directory`)

## Snippets

Organized under `snippets/<major-mode>/`. Modes covered: `emacs-lisp-mode`, `nix-mode`, `org-mode`, `python-mode`, `scala-mode`, `sh-mode`.
