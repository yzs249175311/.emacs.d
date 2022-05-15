(use-package company
  :hook
  (after-init . global-company-mode)
  )

(use-package yasnippet-snippets
  :bind ("C-c i" . #'yas-insert-snippet)
  :hook 
  (flymake-mode . yas-global-mode)
  )

(use-package emmet-mode
  :hook
  (html-mode . emmet-mode)
  (css-mode . emmet-mode)
  :bind (:map emmet-mode-keymap
         ("M-/" . emmet-expand-yas)))


(use-package eglot
  :hook
  (js-mode . eglot-ensure)
  (html-mode . eglot-ensure)
  (css-mode . eglot-ensure)
  :bind
  (:map eglot-mode-map
        ("C-c <tab>" . #'company-complete)
        ("C-c e n" . #'flymake-goto-next-error)
        ("C-c e p" . #'flymake-goto-prev-error)
        ("C-c e f" . #'eglot-format)
        ("C-c e r" . #'eglot-rename))
  )

(provide 'emacs-code-config)
