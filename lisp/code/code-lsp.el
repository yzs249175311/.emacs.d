;;; code-lsp.el --- custom config -*- lexical-binding:t -*-

;;; Commentary:

;;; Code:
(use-package lsp-mode
	:init
	(setq lsp-keymap-prefix "C-c l")
	(defun my/lsp-mode-setup-completion ()
		(setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
					'(orderless))

		(setq-local completion-at-point-functions
								(list
								 (lambda ()
									 (cape-wrap-super
										#'lsp-completion-at-point
										#'cape-file
										(cape-company-to-capf
										 (apply-partially
											#'company--multi-backend-adapter
											'(company-yasnippet))))))))

	:custom
	;; (lsp-completion-provider :none)
	(lsp-auto-execute-action nil)
	(lsp-typescript-suggest-auto-imports t)
	:hook ;; replace XXX-mode with concrete major-mode(e. g. python-mode)
	;; (lsp-completion-mode . my/lsp-mode-setup-completion)
	(web-mode . lsp)
	(js-mode . lsp)
	(js-ts-mode . lsp)
	(tsx-ts-mode . lsp)
	(js-jsx-mode . lsp)
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
	;; (lsp-completion-mode . yzs/lsp-mode-setup-completion)
	;; if you want which-key integration
	(lsp-mode . lsp-enable-which-key-integration)
	:commands lsp
	:bind
	(:map lsp-mode-map
				;; ([remap prog-fill-reindent-defun] . lsp-format-buffer)
				;; ([remap fill-paragraph] . lsp-format-buffer)
				([remap xref-find-references] . lsp-find-references)
				([remap evil-goto-definition] . lsp-find-definition)
				))

(use-package lsp-ui
	:after lsp-mode
  :init
  (setq lsp-ui-sideline-show-hover nil
				lsp-ui-sideline-show-code-actions nil
				lsp-ui-sideline-show-diagnostics t
				lsp-ui-doc-position 'top
				lsp-ui-doc-show-with-cursor t
				lsp-ui-imenu-auto-refresh 'after-save
				lsp-ui-doc-delay 2)
	:hook
	(lsp-mode . lsp-ui-mode)
	:bind
	(:map lsp-mode-map
				("C-c l T m" . lsp-ui-imenu)
				)
	;; (:map lsp-ui-mode-map
	;; 			([remap xref-find-references] . lsp-ui-peek-find-references)
	;; 			([remap evil-goto-definition] . lsp-ui-peek-find-definitions))
	)


(use-package lsp-treemacs
  :after (lsp-mode treemacs)
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

;;; code-lsp.el ends here
