(use-package flycheck
  :init
  (global-flycheck-mode 1)
  :hook
  (org-mode . (lambda () (flycheck-mode -1))))

(use-package prettier
  :hook
  (after-init . #'global-prettier-mode)
  :bind
  (:map global-prettier-mode
		([remap fill-paragraph] . prettier-prettify))
  )

(use-package yaml-mode)
(use-package markdown-mode)
(use-package yuck-mode)
(use-package json-mode
  :if (version< emacs-version "29"))
(use-package dockerfile-mode)
(use-package typescript-mode
  :if (version< emacs-version "29")
  :mode "\\.ts\\'")

(add-to-list 'auto-mode-alist '("\\.cjs\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.mjs\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(add-to-list 'auto-mode-alist '("\\.toml\\'" . toml-mode))

;; (if (display-graphic-p)
;; 	(require 'code-lsp-bridge)
;;   (require 'code-lsp)
;;   )

(require 'code-lsp)
(require 'code-web)

(provide 'emacs-code-config)
