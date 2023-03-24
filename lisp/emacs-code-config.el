(use-package flycheck
  :init
  (global-flycheck-mode 1)
  :hook
  (org-mode . (lambda () (flycheck-mode -1))))

(use-package yaml-mode)
(use-package json-mode)
(use-package markdown-mode)
(use-package yuck-mode)
(use-package dockerfile-mode)
(use-package typescript-mode
  :mode "\\.ts\\'")

(require 'code-web)

;; (if (display-graphic-p)
;; 	(require 'code-lsp-bridge)
;;   (require 'code-lsp)
;;   )

(require 'code-lsp)

(provide 'emacs-code-config)
