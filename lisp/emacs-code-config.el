(use-package company
  :hook
  (after-init . global-company-mode)
  )

(use-package yasnippet-snippets
  :init
  (yas-global-mode 1)
  :bind ("C-c i" . #'yas-insert-snippet)
  )

(use-package emmet-mode
  :hook
  (html-mode . emmet-mode)
  :bind
  (:map html-mode-map
        ("M-/" . emmet-expand-yas)))

(provide 'emacs-code-config)
