(use-package org
  :bind (:map org-mode-map
              ("C-c m a" . org-agenda))
  :config 
  (progn 
    (setq org-adapt-indentation t
          org-hide-leading-stars t
          org-src-fontify-natively t
          org-startup-folded nil
          org-return-follows-link t
          org-startup-truncated nil
          org-log-done t
          org-log-into-drawer t
          org-ellipsis " ▼"
          org-hide-emphasis-markers t)
    (font-lock-add-keywords 'org-mode 
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "►")))))))
  :hook 
  (org-mode . org-indent-mode)
  ;; (org-mode . org-num-mode)
  :custom
  (setq org-capture-templates 
        '(("r" "Read Books")
          ("rb" "Books" entry (file+olp "d:/NutStore/note/GTD/read.org" "读书目录")
           "\n** TODO %^{Book name} - %^{Author}" :kill-buffer t))))

(use-package org-bullets
  :hook
  (org-mode . org-bullets-mode)
  )

(use-package visual-fill-column
  :init (setq visual-fill-column-width 120 
              visual-fill-column-center-text t)
  :hook
  (org-mode . visual-fill-column-mode))

(provide 'emacs-org-config)
