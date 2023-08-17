;;; code-lsp-bridge.el --- lsp-bridge config -*- lexical-binding:t -*-

;;; Commentary:

;;; Code:
(use-package lsp-bridge
  :if (display-graphic-p)
  :ensure nil
  :after yasnippet
  :load-path "~/.emacs.d/site-lisp/lsp-bridge"
  :init
  (require 'lsp-bridge)
  (global-lsp-bridge-mode)
  :config
  (add-to-list 'lsp-bridge-single-lang-server-mode-list '(json-mode . "vscode-json-language-server"))

  (when (assoc 'typescript-mode lsp-bridge-string-interpolation-open-chars-alist)
	(setf (alist-get 'typescript-mode lsp-bridge-string-interpolation-open-chars-alist) "{\\|\"\\|\'")
	)
  (when (assoc 'js-mode lsp-bridge-string-interpolation-open-chars-alist)
	(setf (alist-get 'js-mode lsp-bridge-string-interpolation-open-chars-alist) "{\\|\"\\|\'")
	)
  :custom
  (lsp-bridge-enable-hover-diagnostic t)
  (acm-enable-doc nil)
  (acm-enable-tabnine t)
  :bind
  (:map lsp-bridge-mode-map
		("M-/" . 'lsp-bridge-popup-complete-menu)
		([remap evil-goto-definition] . 'lsp-bridge-find-def))

  (:map acm-mode-map
		("RET" . nil))
)

(provide 'code-lsp-bridge)

;;; code-lsp-bridge.el ends here
