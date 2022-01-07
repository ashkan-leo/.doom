;;; init.el -*- lexical-binding: t; -*-

(doom!

 :completion
 (company
  +childframe)
 (vertico
  +icons)

 :ui
 fill-column
 minimap
 workspaces
 hydra
 deft
 doom
 doom-dashboard
 ophints
 hl-todo
 modeline
 nav-flash
 (emoji
  +ascii
  +github
  +unicode)
 (treemacs
  +lsp)
 (popup
  +all
  +defaults
  +icons)
 (ligatures)

 unicode
 vc-gutter
 vi-tilde-fringe
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
 format
 multiple-cursors
 parinfer
 rotate-text

 :emacs
 (dired
  +icons)
 electric
 ibuffer
 undo
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
 grammar
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
 make
 pass
 pdf
 tmux
 upload
 biblio

 :lang
 rst
 terra
 yaml
 json
 data
 emacs-lisp
 (haskell
  +lsp)
 (java
  +lsp)
 (javascript
  +lsp)
 (latex
  +latexmk
  +cdlatex
  +lsp
  +fold)
 ledger
 (markdown +grip)
 nix
 (org
  +present
  +pretty
  +roam2
  +pomodoro
  +pandoc
  +noter
  +jupyter
  +dragndrop
  +hugo
  +brain
  +gnuplot)
 plantuml
 (python
  +lsp
  +pyright
  +poetry)
 (rust
  +lsp)
 rest
 (scala
  +lsp)
 (sh
  +lsp
  +powershell
  +fish)
 web

 :app
 (rss
  +org)
 everywhere

 :collab
 ;;floobits          ; peer programming for a price
 ;;impatient-mode    ; show off code over HTTP

 :config
 literate

 (default
   +bindings
   +smartparens))
