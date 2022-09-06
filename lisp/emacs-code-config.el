(require 'web-code)

(use-package company
  :hook
  (after-init . global-company-mode)
  (web-mode . (lambda ()
				(define-key web-mode-map (kbd "C-'") 'company-web-html)
                (set (make-local-variable 'company-backends) '(company-web-html))))
  :bind
  (:map company-mode-map
        ("C-M-i" . company-complete))
  :config
  (setq company-minimum-prefix-length 1)
  )
(use-package company-web)

(use-package yasnippet
  :hook
  (org-mode . yas-minor-mode)
  (js-mode . yas-minor-mode)
  (css-mode . yas-minor-mode)
  (web-mode . yas-minor-mode)
  (typescript-mode . yas-minor-mode)
  )
(use-package yasnippet-snippets
  :after yasnippet
  :bind
  (:map yas-minor-mode-map
		("M-/" . yas-expand)))


(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook ;; replace XXX-mode with concrete major-mode(e. g. python-mode)
  (web-mode . lsp)
  (js-mode . lsp)
  (css-mode . lsp)
  (typescript-mode . lsp)
  (lsp-mode . hs-minor-mode)
  ;; if you want which-key integration
  (lsp-mode . lsp-enable-which-key-integration)
  :commands lsp
  )

(use-package lsp-ui
  :init
  (setq lsp-ui-sideline-show-hover nil
		lsp-ui-sideline-show-code-actions t
		lsp-ui-sideline-show-diagnostics t
		lsp-ui-doc-position 'top
		lsp-ui-doc-show-with-cursor t
		lsp-ui-imenu-auto-refresh 'after-save
		lsp-ui-doc-delay 2)
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  :bind
  (:map lsp-ui-mode-map
		("C-c l T m" . 'lsp-ui-imenu)
		))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map))

(provide 'emacs-code-config)
