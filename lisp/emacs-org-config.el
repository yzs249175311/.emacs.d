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
          org-hide-emphasis-markers t
		  ;; org-html-head-include-default-style nil
		  org-html-head-extra "<style>
                                    pre.src{background:#343131;color:white;}
                                    #content{max-width:1800px;}
                                    p{max-width:800px;}
                                    li{max-width:800px;}
                              </style>"
		  )
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

(use-package htmlize)


;; begin 
;; add "#+setupfile:" to every .org buffer
(defcustom yzs/setup-file '("https://fniessen.github.io/org-html-themes/org/theme-readtheorg.setup")
  "list of string with setup file or functions.

Functions must take care of keyword themselves and must return
strings.")

(defcustom yzs/setup-file-keyword "#+setupfile: "
  "Keyword used by `yzs/org-export-setup-files'")

(defun yzs/org-export-setup-files (backend)
  "Include setup-files automatically.  

See also `yzs/setup-file' and `yzs/setup-file-keyword'"
  ;; TODO: Resolve local files.
  ;; TODO: Better control over where contents is inserted.
  (save-excursion
	(goto-char (point-min))
	(insert (mapconcat
			 (lambda (elm)
			   (cond ((stringp elm)
					  (concat yzs/setup-file-keyword elm))
					 (functionp elm) (funcall elm)
					 (t (error "`yzs/setup-file' should contain only strings and functions!"))))
			 yzs/setup-file
			 "\n") "\n")))

(add-hook 'org-export-before-processing-hook
      'yzs/org-export-setup-files)

;; end

(provide 'emacs-org-config)
