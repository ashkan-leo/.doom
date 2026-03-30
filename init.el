;;; init.el -*- lexical-binding: t; -*-

(doom!

 :completion
 (corfu
  +icons
  +orderless)
 (vertico
  +icons)

 :ui
 ;;fill-column
 ;;minimap
 workspaces
 ;;hydra
 ;;deft
 doom
 doom-dashboard
 ophints
 hl-todo
 modeline
 nav-flash
 (treemacs
  +lsp)
 (popup
  +all
  +defaults
  +icons)
 (ligatures)

 unicode
 vc-gutter
 ;;vi-tilde-fringe
 (window-select
  +numbers)
 zen

 :editor
 (evil
  +everywhere)
 word-wrap
 file-templates
 snippets
 fold
 (format
  +onsave
  +lsp)
 multiple-cursors
 parinfer
 rotate-text

 :emacs
 (dired
  +icons)
 electric
 ibuffer
 (undo +tree)
 vc

 :term
 eshell
 vterm

 :os
 macos
 tty

 :checkers
 (spell
  +flyspell
  +hunspell)
 ;; grammar
 (syntax
  +childframe)


 :tools
 ansible
 editorconfig
 taskrunner
 (lookup
  +docsets
  +dictionary)
 (eval
  +overlay)
 (debugger)
 tree-sitter
 ;; +realgud FIXME upstream is broken (only on mac maybe?)

 direnv
 docker
 terraform
 ;; ein
 gist
 (lsp
  +peek)
 (magit
  +forge)
 llm
 make
 pass
 pdf
 tmux
 ;;upload
 biblio

 :lang
 erlang
 (elixir +lsp +tree-sitter)
 ;;rst
 ;;terra
 (yaml +tree-sitter)
 (json +tree-sitter)
 data
 emacs-lisp
 (haskell
  +lsp
  +tree-sitter)
 (java
  +lsp
  +tree-sitter)
 (javascript
  +lsp
  +tree-sitter)
 (latex
  +latexmk
  +cdlatex
  +lsp
  +fold)
 ledger
 (markdown
  +grip
  +tree-sitter)
 (nix
  +lsp
  +tree-sitter)
 (org
  +present
  +roam
  +pomodoro
  +pandoc
  +noter
  +jupyter
  +dragndrop
  +hugo
  +gnuplot)
 plantuml
 (python
  +lsp
  +pyright
  +poetry
  +tree-sitter
  +uv)
 (rust
  +lsp
  +tree-sitter)
 rest
 (scala
  +lsp
  +tree-sitter)
 (sh
  +lsp
  +fish
  +tree-sitter)
 web

 :app
 (rss
  +org)
 ;;everywhere

 :collab
 ;;floobits          ; peer programming for a price
 ;;impatient-mode    ; show off code over HTTP

 :config
 literate

 (default
  +bindings
  +smartparens))
