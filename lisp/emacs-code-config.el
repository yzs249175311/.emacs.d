(require 'code-html)

(use-package company
  :hook
  (after-init . global-company-mode)
  (web-mode . (lambda ()
                (set (make-local-variable 'company-backends) '(company-web-html company-files))))
  :bind
  (:map company-mode-map
        ("C-M-i" . company-complete))
  )

(use-package yasnippet-snippets
  :bind ("C-c i" . #'yas-insert-snippet)
  :hook 
  (org-mode . yas-minor-mode)
  (js-mode . yas-minor-mode)
  (css-mode . yas-minor-mode)
  (web-mode . yas-minor-mode)
  (typescript-mode . yas-minor-mode)
)

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
         (js-mode . lsp)
         (css-mode . lsp)
         (typescript-mode . lsp)
         (web-mode . emmet-mode)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)
;; optionally


(provide 'emacs-code-config)
