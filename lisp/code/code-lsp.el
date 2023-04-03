(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  
  ;; (defun yzs/lsp-mode-setup-completion ()
  ;; 	(setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
  ;; 		  '(orderless)))
  ;; Configure orderless
  ;; same definition as mentioned earlier
  ;; (advice-add 'json-parse-string :around
  ;; 			  (lambda (orig string &rest rest)
  ;; 				(apply orig (s-replace "\\u0000" "" string)
  ;; 					   rest)))

  ;; ;; minor changes: saves excursion and uses search-forward instead of re-search-forward
  ;; (advice-add 'json-parse-buffer :around
  ;; 			  (lambda (oldfn &rest args)
  ;; 				(save-excursion 
  ;; 				  (while (search-forward "\\u0000" nil t)
  ;; 					(replace-match "" nil t)))
  ;; 				(apply oldfn args)))

  :custom
  (lsp-completion-provider :none)
  (lsp-auto-execute-action nil)
  ;; (lsp-typescript-suggest-auto-imports nil)

  :hook ;; replace XXX-mode with concrete major-mode(e. g. python-mode)
  (web-mode . lsp)
  (js-mode . lsp)
  (js-ts-mode . lsp)
  (javascript-mode . lsp)
  (css-mode . lsp)
  (css-ts-mode . lsp)
  (typescript-mode . lsp)
  (typescript-ts-mode . lsp)
  (c-mode . lsp)
  (c-ts-mode . lsp)
  (c++-mode . lsp)
  (c++-ts-mode . lsp)
  (json-mode . lsp)
  (jsonc-mode . lsp)
  (json-ts-mode . lsp)
  (lsp-mode . hs-minor-mode)
  ;; (lsp-completion-mode . yzs/lsp-mode-setup-completion)
  ;; if you want which-key integration
  (lsp-mode . lsp-enable-which-key-integration)
  :commands lsp
  :config
  (evil-define-key 'normal lsp-mode-map (kbd "g D") 'lsp-find-references)
  )

;; (use-package lsp-ui
;;   :init
;;   (setq lsp-ui-sideline-show-hover nil
;; 		lsp-ui-sideline-show-code-actions nil
;; 		lsp-ui-sideline-show-diagnostics nil
;; 		lsp-ui-doc-position 'top
;; 		lsp-ui-doc-show-with-cursor t
;; 		lsp-ui-imenu-auto-refresh 'after-save
;; 		lsp-ui-doc-delay 2)
;;   :hook
;;   (lsp-mode . lsp-ui-mode)
;;   (lsp-ui-mode . (lambda () (setq lsp-ui-peek-list-width (/ (window-width) 2))))
;;   :bind
;;   (:map lsp-mode-map
;; 		("C-c l T m" . lsp-ui-imenu)
;; 		)
;;   (:map lsp-ui-mode-map
;; 		([remap xref-find-references] . lsp-ui-peek-find-references)
;; 		([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
;; 		([remap evil-goto-definition] . lsp-ui-peek-find-definitions)
;; 		)
;;   (:map evil-normal-state-map
;; 		("g i" . lsp-ui-peek-find-references))
;;   )

(use-package lsp-treemacs
  :hook
  (lsp-mode . lsp-treemacs-sync-mode)
  )

(use-package consult-lsp
  :after lsp-mode
  :bind
  (:map lsp-command-map
		("C e" . consult-lsp-diagnostics)
		("C s" . consult-lsp-symbols)
		("C f" . consult-lsp-file-symbols)))



(provide 'code-lsp)
