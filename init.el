;;; init.el -*- lexical-binding: t; -*-

(doom! :completion

       (company
        +childframe ;; may cause lag
        )

       (ivy
        ;; +childframe ;; causes lags [in darwin] when the Emacs window is enlarged
        +prescient
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
       indent-guides
       modeline
       nav-flash
       (emoji
        +ascii
        +github
        +unicode)
       (treemacs)
       (popup
        +all
        +defaults
        +icons)
       (ligatures
        ;;  +iosevka
        ;;  +extra) FIXME the extra introduce unsupported characters to JetBrains Mono
        )
       unicode
       vc-gutter
       vi-tilde-fringe
       (window-select
        +numbers)
       zen

       :editor
       (evil +everywhere)
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
       (debugger
        ;; +realgud
        )
       direnv
       docker
       terraform
       ;; ein
       gist
       (lsp +peek)
       (magit +forge)
       make
       pass
       pdf
       tmux
       upload
       biblio

       :lang
       terra
       yaml
       json
       data
       emacs-lisp
       (haskell
        +lsp)
       (java +meghanada)
       javascript
       julia
       (latex
        +latexmk
        +cdlatex
        +fold)
       ledger
       (markdown +grip)
       nix
       (org
        +present
        +pretty
        +roam
        +pomodoro
        +pandoc
        +noter
        +jupyter
        +dragndrop
        +hugo
        +brain
        +gnuplot)
       plantuml
       purescript
       (python
        +lsp
        +pyright
        +poetry)
       racket
       rest
       (scala
        +lsp)
       (sh
        +lsp
        +powershell
        +fish)
       web

       :app
       ;;(email +gmail)    ; emacs as an email client
       ;;irc               ; how neckbeards socialize
       (rss
        +org)        ; emacs as an RSS reader
       ;;twitter           ; twitter client https://twitter.com/vnought

       :collab
       ;;floobits          ; peer programming for a price
       ;;impatient-mode    ; show off code over HTTP

       :config
       literate

       (default
         +bindings
         +smartparens))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((dante-methods stack)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
