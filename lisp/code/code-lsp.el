(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  (defun yzs/lsp-mode-setup-completion ()
	(setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
		  '(orderless))) ;; Configure orderless
  ;; same definition as mentioned earlier
  (advice-add 'json-parse-string :around
			  (lambda (orig string &rest rest)
				(apply orig (s-replace "\\u0000" "" string)
					   rest)))

  ;; ;; minor changes: saves excursion and uses search-forward instead of re-search-forward
  (advice-add 'json-parse-buffer :around
			  (lambda (oldfn &rest args)
				(save-excursion 
				  (while (search-forward "\\u0000" nil t)
					(replace-match "" nil t)))
				(apply oldfn args)))
  :custom
  (lsp-completion-provider :none)
  ;; (lsp-typescript-suggest-auto-imports nil)
  :hook ;; replace XXX-mode with concrete major-mode(e. g. python-mode)
  (web-mode . lsp)
  (js-mode . lsp)
  (javascript-mode . lsp)
  (css-mode . lsp)
  (typescript-mode . lsp)
  (c-mode . lsp)
  (c++-mode . lsp)
  (lsp-mode . hs-minor-mode)
  (lsp-completion-mode . yzs/lsp-mode-setup-completion)
  ;; if you want which-key integration
  (lsp-mode . lsp-enable-which-key-integration)
  :commands lsp
  )

(use-package lsp-ui
  :init
  (setq lsp-ui-sideline-show-hover nil
		lsp-ui-sideline-show-code-actions nil
		lsp-ui-sideline-show-diagnostics nil
		lsp-ui-doc-position 'top
		lsp-ui-doc-show-with-cursor t
		lsp-ui-imenu-auto-refresh 'after-save
		lsp-ui-doc-delay 2)
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  (define-key lsp-ui-mode-map [remap evil-goto-definition] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap evil-insert-resume] #'lsp-ui-peek-find-references)
  :bind
  (:map lsp-mode-map
		("C-c l T m" . 'lsp-ui-imenu)
		)
  )

(use-package lsp-treemacs
  :hook
  (lsp-mode . lsp-treemacs-sync-mode)
  )



(provide 'code-lsp)
