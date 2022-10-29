(use-package emmet-mode
  :bind (:map emmet-mode-keymap
              ("M-/" . emmet-expand-yas))
  :hook
  (web-mode . emmet-mode)
  (css-mode . emmet-mode)
  )

;;(use-package company-web
;;  :init (progn
;;          (add-to-list 'company-backends 'company-web-html)))

(use-package web-mode
  :mode ("\\.vue\\'" "\\.html?\\'")
  :config
  (add-to-list 'hs-special-modes-alist '(web-mode  "{\\|<[^/>]+?" "}\\|</[^/>]*[^/]>" "<!--" web-mode-forward-sexp nil))
  )

(use-package auto-rename-tag
  :hook 
  (web-mode . auto-rename-tag-mode)
  )


(use-package typescript-mode
  :config
  (add-to-list 'auto-mode-alist
               '("\\.ts\\'" . typescript-mode))
  )
;; (defun open-html-in-server () 
;;   (interactive)
;;   (shell-command-to-string (format "browser-sync --server --file \"%s\"" (buffer-file-name))))


;;vue config begin
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package
 '(lsp-volar :type git :host github :repo "jadestrong/lsp-volar"))
(use-package lsp-volar
  :defer nil
  :straight t
  :init
  (setq lsp-typescript-suggest-auto-imports nil))
;;vue config end
(provide 'code-web)
