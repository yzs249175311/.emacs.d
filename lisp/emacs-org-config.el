(use-package org
  :bind (:map org-mode-map
         ("C-c m a" . org-agenda))
  :config 
  (progn 
    (setq org-adapt-indentation t
          org-hide-leading-stars t)
    (setq org-src-fontify-natively t)
    (setq org-startup-folded nil)
    (setq org-return-follows-link t)
    (setq org-startup-truncated nil)
    (setq org-log-done t)
    (setq org-log-into-drawer t))
  :hook 
  (org-mode . org-indent-mode)
  ;; (org-mode . org-num-mode)
  )


(provide 'emacs-org-config)
