(setq custom-file (locate-user-emacs-file "custom.el"))

(load custom-file)

(setq ns-command-modifier 'meta)

(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))
(setq use-package-always-ensure t)
(package-initialize)

(use-package exec-path-from-shell
  :ensure t
  :init
  (exec-path-from-shell-initialize)
  )

(setq-default ring-bell-function 'ignore)

(fset 'yes-or-no-p 'y-or-n-p)

(setq-default cursor-type 'bar)
    (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
    (tool-bar-mode -1)
    (scroll-bar-mode -1)

(use-package solo-jazz-theme
  :ensure t
  :init
  (load-theme 'solo-jazz t))

(set-face-attribute 'default nil
                      :family     "Go Mono"
                      :height       160)

(global-set-key (kbd "C-x C-m") 'execute-extended-command)
(global-set-key (kbd "C-x b") 'switch-to-buffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x k") 'kill-current-buffer)

(global-set-key (kbd "C-c C-b") 'previous-buffer)
(global-set-key (kbd "C-c C-f") 'next-buffer)

(defun reload-init-file ()
	 (interactive)
	 (load-file user-init-file))
(global-set-key (kbd "C-c C-r") 'reload-init-file)

(use-package vertico
  :ensure t
  :custom
  (vertico-scroll-margin 0)
  (vertico-count 20)
  (vertico-resize t)
  (vertico-cycle t) 
  :init
  (vertico-mode))

(use-package savehist

  :init
  (savehist-mode))

(use-package orderless
:ensure t
:custom
(completion-category-defaults nil)
(completion-styles '(orderless basic))
(completion-category-overrides '((file (styles partial-completion))))
(completion-pcm-leading-wildcard t)
)

(use-package consult
   :ensure t
  ;; Replace bindings. Lazily loaded by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g r" . consult-grep-match)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-find)                  ;; Alternative: consult-fd
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("C-s" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Tweak the register preview for `consult-register-load',
  ;; `consult-register-store' and the built-in commands.  This improves the
  ;; register formatting, adds thin separator lines, register sorting and hides
  ;; the window mode line.
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep consult-man
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (keymap-set consult-narrow-map (concat consult-narrow-key " ?") #'consult-narrow-help)
)

(setopt tab-always-indent 'complete)

(use-package corfu
    :after orderless
    :ensure t
    :custom
    (corfu-quit-at-boundary nil)
    (corfu-quit-no-match t)
    (corfu-auto-prefix 1)
    (corfu-auto t)
(corfu-auto-delay 0.0)
    :init
  (global-corfu-mode))

(use-package magit)

(use-package project
  :custom
  (project-vc-extra-root-markers '(".project" "workspace.edn" ".dir-locals.el"))
  )

(use-package org
:defer t

:bind ("C-c a" . org-agenda-list)

:config
;; Resize Org headings
(custom-set-faces
'(org-document-title ((t (:height 1.4))))
'(org-level-1          ((t (:height 1.7))))
'(org-level-2          ((t (:height 1.5))))
'(org-level-3          ((t (:height 1.25))))
'(org-level-4          ((t (:height 1.2))))
'(org-level-5          ((t (:height 1.2))))
'(org-level-6          ((t (:height 1.2))))
'(org-level-7          ((t (:height 1.2))))
'(org-level-8          ((t (:height 1.2))))
'(org-level-9          ((t (:height 1.2)))))

(plist-put org-format-latex-options :scale 2)

:custom
(org-hide-leading-stars t)
(org-pretty-entities t)
(org-startup-indented t)
(org-startup-folded 'content)

(org-preview-latex-default-process 'dvisvgm)

)

(use-package smartparens
   :ensure t
   :hook (prog-mode)
   :custom
   (sp-base-key-bindings 'sp)
   (sp-override-key-bindings
   '(("C-t" . sp-transpose-sexp)
     ("C-M-t" . sp-backward-transpose-sexp)
     ("C-k" . sp-kill-hybrid-sexp)
     ("C-c C-<right>" . sp-slurp-hybrid-sexp)
            ))
   :config
   (defun sp-backward-transpose-sexp ()
     (interactive)
     (sp-transpose-sexp -1)
     )
)

(use-package eglot
:ensure t
:hook ((( clojure-mode clojurec-mode clojurescript-mode
          java-mode scala-mode)
        . eglot-ensure)
       )
:custom
    (eldoc-echo-area-use-multiline-p nil)
    (eglot-autoshutdown t)
(eglot-events-buffer-size 0)
(eglot-extend-to-xref nil)
)

(use-package cider :ensure t)
(put 'dired-find-alternate-file 'disabled nil)
