;; -*- no-byte-compile: t; -*-

;; org extensions
(package! org-drill)
(package! org-super-agenda)
(package! org-fancy-priorities)
(package! org-ref)
(package! org-noter-pdftools)
(package! org-roam-bibtex :recipe (:host github :repo "org-roam/org-roam-bibtex"))

;; org exporters
(package! ox-moderncv :recipe (:host gitlab :repo "Titan-C/org-cv"))
(package! ox-altacv   :recipe (:host gitlab :repo "Titan-C/org-cv"))
(package! org-fs-tree :recipe (:host github :repo "ScriptDevil/org-fs-tree"))

;; ui
(package! nyan-mode)

;; dash at point
(package! counsel-dash)
(package! dash-at-point)
(package! helm-dash)

;; tools
(package! real-auto-save)
(package! sphinx-doc)

(unpin! org-roam company-org-roam)
(unpin! bibtex-completion helm-bibtex ivy-bibtex)
;; (unpin! lsp-mode)

;; (package! exec-path-from-shell)
