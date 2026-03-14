;; -*- no-byte-compile: t; -*-

;; org extensions
(package! org-drill)
(package! org-super-agenda)
(package! org-ref)
(package! org-noter-pdftools)
(package! org-roam-bibtex :recipe (:host github :repo "org-roam/org-roam-bibtex"))
(package! org-fragtog)

;; org resume exporters
(package! ox-moderncv :recipe (:host gitlab :repo "Titan-C/org-cv"))

;; org babel
(package! ob-prolog)

;; dash at point
(package! dash-at-point)

;; prolog
(package! ediprolog)
;; TODO how to install this?
;; (package! prolog :recipe (:host github :ropo "jamesnvc/lsp_server"))

;; justfile support
(package! just-mode)
(package! justl)
(package! sphinx-doc)

(unpin! org-roam)
(unpin! bibtex-completion helm-bibtex ivy-bibtex)

;; claude code ide - agentic Claude Code CLI integration
(package! claude-code-ide
  :recipe (:host github :repo "manzaltu/claude-code-ide.el"))

(package! copilot
  :recipe (:host github :repo "zerolfx/copilot.el" :files ("*.el" "dist")))
