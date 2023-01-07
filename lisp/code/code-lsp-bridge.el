(use-package lsp-bridge
  :ensure nil
  :after yasnippet
  :load-path "~/.emacs.d/straight/repos/lsp-bridge/acm"
  :load-path "~/.emacs.d/straight/repos/lsp-bridge"
  :straight '(lsp-bridge :type git :host github :repo "manateelazycat/lsp-bridge")
  :init
  (global-lsp-bridge-mode)
  :bind
  (:map acm-mode-map
		("RET" . nil))
  :custom
  (lsp-bridge-enable-hover-diagnostic t)
  (acm-enable-doc nil)
  )

;; (use-package popon
;;   :ensure nil
;;   :straight t)

;; (use-package acm-terminal
;;   :if (not (display-graphic-p))
;;   :ensure nil
;;   :load-path "~/.emacs.d/straight/repos/acm-terminal"
;;   :straight '(acm :type git :host github :local-repo "~/.emacs.d/straight/repos/lsp-bridge/acm")
;;   :straight '(acm-terminal :type git :host github :repo "twlz0ne/acm-terminal")
;;   )

(provide 'code-lsp-bridge)
