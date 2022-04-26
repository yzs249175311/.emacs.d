(progn
  ;; org-mode
  ;; make “org-mode” syntax color code sections
  (setq org-src-fontify-natively t)
  (setq org-startup-folded nil)
  (setq org-return-follows-link t)
  (setq org-startup-truncated nil))

(setq org-adapt-indentation t
      org-hide-leading-stars t
      org-odd-levels-only t)

(with-eval-after-load 'org
    (define-key org-mode-map (kbd "C-c a") 'org-agenda))

(provide 'yzs-emacs-org)
