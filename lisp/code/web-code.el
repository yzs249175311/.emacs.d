(use-package emmet-mode
  :bind (:map emmet-mode-keymap
              ("M-/" . emmet-expand-yas))
  :hook
  (web-mode . emmet-mode)
  )

;;(use-package company-web
;;  :init (progn
;;          (add-to-list 'company-backends 'company-web-html)))

(use-package auto-rename-tag
  :hook 
  (web-mode . auto-rename-tag-mode)
  )

(use-package web-mode
  :init
  (add-to-list 'auto-mode-alist 
               '("\\.html?\\'" . web-mode))
  )

(use-package typescript-mode
  :config
  (add-to-list 'auto-mode-alist
               '("\\.ts\\'" . typescript-mode))
  )
;; (defun open-html-in-server () 
;;   (interactive)
;;   (shell-command-to-string (format "browser-sync --server --file \"%s\"" (buffer-file-name))))

(provide 'web-code)
