(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   '((eval defun datomic.sqlite/conn nil "Connect to the Datomic SQLite database in ./storage/sqlite.db"
	   (interactive)
	   (let
	       ((ns
		 (cider-current-ns)))
	     (cider-nrepl-sync-request:eval
	      (format "(in-ns '%s)\12              (def conn (d/connect \"datomic:sql://app?jdbc:sqlite:./storage/sqlite.db\"))" ns))))
     (eval add-hook 'after-save-hook
	   (lambda nil
	     (if
		 (y-or-n-p "Tangle?")
		 (org-babel-tangle)))
	   nil t)
     (eval add-hook 'after-save-hook
	   (lambda nil
	     (if
		 (y-or-n-p "Reload?")
		 (load-file user-init-file)))
	   nil t))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#fafafa" :foreground "#3b2685" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 150 :width normal :foundry "nil" :family "Go Mono"))))
 '(org-document-title ((t (:height 1.4))))
 '(org-level-1 ((t (:height 1.7))))
 '(org-level-2 ((t (:height 1.5))))
 '(org-level-3 ((t (:height 1.25))))
 '(org-level-4 ((t (:height 1.2))))
 '(org-level-5 ((t (:height 1.2))))
 '(org-level-6 ((t (:height 1.2))))
 '(org-level-7 ((t (:height 1.2))))
 '(org-level-8 ((t (:height 1.2))))
 '(org-level-9 ((t (:height 1.2)))))
