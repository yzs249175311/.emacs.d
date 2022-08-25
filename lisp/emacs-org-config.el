(use-package org
  :bind ("C-c o a" . org-agenda)
  :config 
  (progn 
    (setq org-adapt-indentation t
          org-hide-leading-stars t
          org-src-fontify-natively t
		  org-src-tab-acts-natively t
          org-startup-folded nil
          org-return-follows-link t
          org-startup-truncated nil
          org-log-done t
          org-log-into-drawer t
          org-ellipsis " ▼"
          org-hide-emphasis-markers t)
    ;;修改无序列表的符号 - 
    (font-lock-add-keywords 'org-mode 
                            '(("^ *\\([-]\\) "
                               (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "⇒")))))))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((js . t)
     (shell . t)))
  :hook 
  (org-mode . org-indent-mode)
  ;; (org-mode . org-num-mode)
  :custom
  (org-capture-templates 
   '(("r" "Read Books")
     ("rb" "Books" entry (file+olp "d:/NutStore/note/GTD/read.org" "读书目录")
      "\n** TODO %^{Book name} - %^{Author}" :kill-buffer t))))

(use-package org-bullets
  :hook
  (org-mode . org-bullets-mode)
  )


(provide 'emacs-org-config)
