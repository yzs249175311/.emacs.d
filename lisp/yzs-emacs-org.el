(use-package org
  :bind (:map org-mode-map
              ("C-c a" . org-agenda))
  :config 
  (progn 
    (setq org-adapt-indentation t
          org-hide-leading-stars t)

    (setq org-src-fontify-natively t)
    (setq org-startup-folded nil)
    (setq org-return-follows-link t)
    (setq org-startup-truncated nil))
  :hook 
  (org-mode . org-indent-mode)
  )


(provide 'yzs-emacs-org)
