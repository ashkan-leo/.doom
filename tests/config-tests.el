;;; config-tests.el --- ERT tests for Doom config -*- lexical-binding: t -*-
;;
;; Lives at: ~/.config/doom/tests/config-tests.el
;;
;; Run via:  ~/.config/doom/bin/doom-check
;;
;; Or directly:
;;   /Applications/Emacs.app/Contents/MacOS/Emacs --batch -Q \
;;     --load ~/.config/doom/tests/config-tests.el \
;;     --eval "(ert-run-tests-batch-and-exit)"
;;
;; Strategy: stub Doom macros to *record* calls instead of executing them,
;; then load config.el and assert against the recorded data.

(require 'cl-lib)
(require 'ert)

;;; ── Bootstrap ────────────────────────────────────────────────────────────────

(defvar ct/doom-dir (expand-file-name "~/.config/doom/"))
(defvar ct/config-el (expand-file-name "config.el" ct/doom-dir))

;; Doom variables config.el references
(defvar doom-user-dir ct/doom-dir)
(defvar doom-private-dir ct/doom-dir)
(defvar doom-version "3.0.0-pre")
(defvar doom-theme nil)
(defvar doom-font nil)
(defvar doom-variable-pitch-font nil)
(defvar doom-big-font nil)

;; User variables declared in config
(defvar pipboy/org-notes "~/w/roam/")
(defvar pipboy/gtd-directory "~/w/beorg/")

;;; ── Call recorders ───────────────────────────────────────────────────────────

(defvar ct/after-calls   nil "Recorded after! calls: list of (features body)")
(defvar ct/hooks         nil "Recorded add-hook! calls: list of (hooks fns)")
(defvar ct/map-calls     nil "Recorded map! calls: list of arg lists")
(defvar ct/packages      nil "Recorded use-package! calls: list of (name args)")
(defvar ct/load-errors   nil "Errors from loading config.el")

;;; ── Doom macro stubs ─────────────────────────────────────────────────────────

(defmacro after! (features &rest body)
  `(push (list :features ',features :body ',body) ct/after-calls))

(defmacro use-package! (name &rest args)
  `(push (list :name ',name :args ',args) ct/packages))

(defmacro map! (&rest args)
  `(push ',args ct/map-calls))

(defmacro add-hook! (hooks &rest fns)
  `(push (list :hooks ',hooks :fns ',fns) ct/hooks))

(defmacro setq-hook!    (&rest _) nil)
(defmacro remove-hook!  (&rest _) nil)
(defmacro add-transient-hook! (&rest _) nil)
(defmacro defadvice!    (&rest _) nil)
(defmacro undefadvice!  (&rest _) nil)
(defmacro modulep!      (&rest _) nil)

;; setopt: set vars safely, ignoring unknown ones
(defmacro setopt (&rest pairs)
  `(progn
     ,@(cl-loop for (var val) on pairs by #'cddr
                collect `(condition-case nil
                             (set ',var ,val)
                           (error nil)))))

;; Stub package functions that config calls directly
(dolist (fn '(gptel-make-anthropic gptel-make-openai gptel-make-gemini
              gptel-make-ollama gptel-get-backend
              set-company-backend! set-lsp-priority! set-popup-rule!
              set-face-attribute set-mouse-color
              org-babel-do-load-languages
              doom-font-increment doom-themes-treemacs-config
              nyan-mode hide-mode-line-mode writeroom-mode
              copilot-mode claude-code-ide-mode))
  (unless (fboundp fn)
    (fset fn (lambda (&rest _) nil))))

;; custom-set-faces needs special handling (validates face attrs)
(defalias 'custom-set-faces #'ignore)
(defalias 'set-face-background #'ignore)

;;; ── Load config.el ───────────────────────────────────────────────────────────

(condition-case err
    (load ct/config-el nil :nomessage)
  (error
   (push (format "%s" err) ct/load-errors)
   (message "ERROR loading config.el: %s" err)))

;;; ── Tests ────────────────────────────────────────────────────────────────────

(ert-deftest ct/config-loads-without-error ()
  "config.el loads without signalling an error."
  (should (null ct/load-errors)))

;; ── Deprecated / forbidden patterns ──────────────────────────────────────────

(ert-deftest ct/no-setq-bang ()
  "setq! not used — it's an obsolete alias since Doom 3.0 (use setopt)."
  (with-temp-buffer
    (insert-file-contents ct/config-el)
    (should-not (re-search-forward "\\_<setq!\\_>" nil t))))

(ert-deftest ct/no-deprecated-cl ()
  "(require 'cl) not used — use cl-lib."
  (with-temp-buffer
    (insert-file-contents ct/config-el)
    (should-not (search-forward "(require 'cl)" nil t))))

(ert-deftest ct/no-background-nil ()
  "No :background nil face attribute — use 'unspecified."
  (with-temp-buffer
    (insert-file-contents ct/config-el)
    (should-not (search-forward ":background nil" nil t))))

(ert-deftest ct/no-dap-mode ()
  "dap-mode not loaded — Doom uses dape now."
  (let ((dap-after (cl-find-if
                    (lambda (c) (string-match-p "dap"
                                                (format "%s" (plist-get c :features))))
                    ct/after-calls)))
    (should (null dap-after)))
  (with-temp-buffer
    (insert-file-contents ct/config-el)
    (should-not (re-search-forward "(require 'dap-" nil t))))

;; ── Python ────────────────────────────────────────────────────────────────────

(ert-deftest ct/sphinx-doc-is-hooked ()
  "sphinx-doc-mode is registered via :hook, not called directly with t."
  (let* ((pkg (cl-find 'sphinx-doc ct/packages :key (lambda (p) (plist-get p :name))))
         (args (and pkg (plist-get pkg :args)))
         (hook-val (and args (cadr (memq :hook args)))))
    ;; Package must exist
    (should pkg)
    ;; Must have a :hook keyword
    (should (memq :hook args))
    ;; Hook value: either a symbol like 'python-mode or a cons (python-mode . sphinx-doc-mode)
    (should (or (eq hook-val 'python-mode)
                (and (consp hook-val)
                     (or (eq (car hook-val) 'python-mode)
                         (eq (cdr hook-val) 'sphinx-doc-mode))))))
  ;; Verify (sphinx-doc-mode t) not present anywhere
  (with-temp-buffer
    (insert-file-contents ct/config-el)
    (should-not (search-forward "(sphinx-doc-mode t)" nil t))))

;; ── LLM / gptel ──────────────────────────────────────────────────────────────

(ert-deftest ct/gptel-helper-fns-defined ()
  "pipboy/gptel-* helpers are defined at top level (not inside after!)."
  (should (fboundp 'pipboy/gptel-send-claude))
  (should (fboundp 'pipboy/gptel-send-groq))
  (should (fboundp 'pipboy/gptel-send-gemini))
  (should (fboundp 'pipboy/gptel-send-openai))
  (should (fboundp 'pipboy/gptel-set-default-backend)))

(ert-deftest ct/gptel-send-with-defined ()
  "pipboy/gptel-send-with helper is defined."
  (should (fboundp 'pipboy/gptel-send-with)))

;; ── Package hygiene ───────────────────────────────────────────────────────────

(ert-deftest ct/use-package-deferred ()
  "Every use-package! has a deferral mechanism."
  (let* ((deferral-keys '(:hook :after :commands :defer :after-call))
         ;; packages that are legitimately eager (document why)
         (whitelist '())
         (eager (cl-remove-if
                 (lambda (pkg)
                   (let ((name (plist-get pkg :name))
                         (args (plist-get pkg :args)))
                     (or (memq name whitelist)
                         (cl-some (lambda (k) (memq k args)) deferral-keys))))
                 ct/packages)))
    (when eager
      (message "Eager use-package! calls: %S"
               (mapcar (lambda (p) (plist-get p :name)) eager)))
    (should (null eager))))

(ert-deftest ct/no-ensure-t ()
  "No :ensure t — Doom uses straight.el, not package.el."
  (let ((bad (cl-find-if (lambda (pkg) (memq :ensure (plist-get pkg :args)))
                         ct/packages)))
    (should (null bad))))

;; ── Keybinding structure ──────────────────────────────────────────────────────

(ert-deftest ct/no-evil-state-in-dap-prefix ()
  "DAP keybindings don't attempt to rebind SPC d (owned by Doom's dape module)."
  (let ((dap-maps (cl-remove-if-not
                   (lambda (call)
                     (let ((s (format "%s" call)))
                       (and (string-match-p "dap" s)
                            (string-match-p ":leader" s))))
                   ct/map-calls)))
    (should (null dap-maps))))

(ert-deftest ct/no-minor-mode-with-t ()
  "No (some-mode t) calls — use +1 or add-hook!."
  (with-temp-buffer
    (insert-file-contents ct/config-el)
    (should-not (re-search-forward "([a-z][a-z-]+-mode t)" nil t))))
