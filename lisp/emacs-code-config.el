(use-package company
  :hook
  (after-init . global-company-mode)
  :bind
  (:map company-mode-map
        ("<TAB>" . #'completion-at-point)))

(use-package yasnippet-snippets
  :bind ("C-c i" . #'yas-insert-snippet)
)

(use-package emmet-mode
  :bind (:map emmet-mode-keymap
         ("M-/" . emmet-expand-yas)))

;; (use-package eglot
;;   :hook
;;   (web-mode . eglot-ensure)
;;   :bind
;;   (:map eglot-mode-map
;;         ("<tab>" . #'company-complete)
;;         ("C-c e n" . #'flymake-goto-next-error)
;;         ("C-c e p" . #'flymake-goto-prev-error)
;;         ("C-c e f" . #'eglot-format)
;;         ("C-c e r" . #'eglot-rename)))

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (web-mode . lsp)
         (web-mode . emmet-mode)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)
;; optionally

(use-package web-mode
  :init
  (add-to-list 'auto-mode-alist 
               '("\\.html?\\'" . web-mode)))

(provide 'emacs-code-config)
