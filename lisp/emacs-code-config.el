(require 'web-code)

(use-package company
  :hook
  (after-init . global-company-mode)
  (web-mode . (lambda ()
                (set (make-local-variable 'company-backends) '(company-web-html company-files))))
  :bind
  (:map company-mode-map
        ("C-M-i" . company-complete))
  )

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
        ("C-c & C-t" . yas-describe-tables))
)


(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook ;; replace XXX-mode with concrete major-mode(e. g. python-mode)
  (web-mode . lsp)
  (js-mode . lsp)
  (css-mode . lsp)
  (typescript-mode . lsp)
  ;; if you want which-key integration
  (lsp-mode . lsp-enable-which-key-integration)
  :commands lsp
  )

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap 
  ("C-c p" . projectile-command-map))

(provide 'emacs-code-config)
