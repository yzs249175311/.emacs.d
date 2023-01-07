(use-package lsp-bridge 
  :ensure nil
  :after yasnippet
  :load-path "~/.emacs.d/straight/repos/lsp-bridge/acm"
  :load-path "~/.emacs.d/straight/repos/lsp-bridge"
  :straight '(lsp-bridge :type git :host github :repo "manateelazycat/lsp-bridge")
  :init
  (global-lsp-bridge-mode)
  )

(provide 'code-lsp-bridge)
