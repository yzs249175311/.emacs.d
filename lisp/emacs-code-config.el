;;; emacs-code-config.el --- code config

;;; Commentary:

;;; Code:
(use-package flycheck
  :init
  (global-flycheck-mode 1)
  :hook
  (org-mode . (lambda () (flycheck-mode -1))))
(use-package prettier)

(use-package yaml-mode)
(use-package markdown-mode)
(use-package yuck-mode)
;; (use-package json-mode
;; 	:if (version< emacs-version "29"))
(use-package dockerfile-mode)
(use-package typescript-mode
	:if (version< emacs-version "29")
	:mode "\\.ts\\'")
(use-package js-jsx-mode
	:ensure nil
	:hook
	(js-jsx-mode . emmet-mode)
	)

(use-package typescript-ts-mode
	:if (version< emacs-version "29")
	:init
	(setf (alist-get "\\.tsx\\'" auto-mode-alist nil 'remove #'equal) nil)
	:hook
	(tsx-ts-mode . (lambda () (setq-local treesit-font-lock-level 4)))
	)

(add-to-list 'auto-mode-alist '("\\.cjs\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.mjs\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(add-to-list 'auto-mode-alist '("\\.toml\\'" . toml-mode))

;; (when (fboundp 'tsx-ts-mode)
;; 	(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))
;; 	(add-hook 'tsx-ts-mode-hook (lambda () (emmet-mode 1))))

;;All major mode indent offset config
(mapc #'(lambda (offset) (defvaralias offset 'tab-width) )
			'(css-indent-offset
				js-jsx-indent-level
				js-indent-level
				typescript-indent-level
				web-mode-code-indent-offset
				web-mode-markup-indent-offset))


(require 'code-lsp)
(require 'code-web)

(provide 'emacs-code-config)

;;; emacs-code-config.el ends here
