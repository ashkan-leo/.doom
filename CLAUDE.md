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
