(use-package flycheck
  :init
  (global-flycheck-mode 1)
  :hook
  (org-mode . (lambda () (flycheck-mode -1))))

(use-package yaml-mode)
(use-package markdown-mode)
(use-package yuck-mode)
(use-package json-mode
  :if (version< emacs-version "29"))
(use-package dockerfile-mode)
(use-package typescript-mode
  :if (version< emacs-version "29")
  :mode "\\.ts\\'")
(use-package nov
  :mode ( "\\.epub\\'" . nov-mode))


(add-to-list 'auto-mode-alist '("\\.cjs\\'" . js-ts-mode))
(add-to-list 'auto-mode-alist '("\\.mjs\\'" . js-ts-mode))


(require 'code-web)

;; (if (display-graphic-p)
;; 	(require 'code-lsp-bridge)
;;   (require 'code-lsp)
;;   )

(require 'code-lsp)

(provide 'emacs-code-config)
