(use-package org
  :config
  (setq org-adapt-indentation t
		org-hide-leading-stars t
		org-src-fontify-natively t
		org-src-tab-acts-natively t
		org-startup-folded nil
		org-return-follows-link t
		org-startup-truncated nil
		org-log-done t
		org-log-into-drawer t
		org-ellipsis " ⤵"
		org-plantuml-jar-path (expand-file-name "~/.emacs.d/.cache/plantuml.jar")
		org-hide-emphasis-markers t
		;; org-html-head-include-default-style nil
		org-html-head-extra "<style>
									pre.src{background:#343131;color:white;}
									#content{max-width:1800px;}
									p{max-width:1600px;}
									li{max-width:1600px;}
							  </style>"
		)

  ;;org refile
  (setq org-refile-targets (mapcar #'(lambda (target) `(,target :maxlevel . 1))
								   org-agenda-files))

  ;;修改无序列表的符号 - 
  (if (display-graphic-p)
	  (font-lock-add-keywords 'org-mode
							  '(("^ *\\([-]\\) " (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "☛"))))
								("^ *\\([+]\\) " (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "☞"))))))
	)

  ;;org babel
  (setq org-confirm-babel-evaluate nil)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((js . t)
	 (shell . t)
	 (plantuml . t)))


  (setq-local yzs/org/org-open-file (pcase system-type
									  ('windows-nt 'system)
									  ('darwin "open %s")
									  ('cygwin "cygstart %s")
									  (_ "xdg-open %s")))

  (setq org-file-apps (reverse (append org-file-apps
									   `(("\\.epub\\'" . ,yzs/org/org-open-file)
										 ("\\.pdf\\'" . ,yzs/org/org-open-file)
										 ))))

  (add-hook 'org-agenda-mode-hook (lambda () (evil-define-key '(motion normal) 'org-agenda-mode-map (kbd "SPC") org-agenda-mode-map))) 

  :hook 
  (org-mode . org-indent-mode)
  (org-babel-after-execute . org-redisplay-inline-images)
  :custom
  (org-capture-templates 
   '(("r" "Read Books")
	 ("rb" "Books" entry (file+olp "d:/NutStore/note/GTD/read.org" "读书目录")
	  "\n** TODO %^{Book name} - %^{Author}" :kill-buffer t))))

(use-package org-bullets
  :if (display-graphic-p)
  :hook
  (org-mode . org-bullets-mode)
  :config
  (if (display-graphic-p)
	  (setq org-bullets-bullet-list '("❋" "✥" "✤" "✣" "✢")))
  )

(use-package htmlize)

(use-package org-roam
  :init 
  (setq find-file-visit-truename t)
  (setq org-roam-completion-everywhere t)
  :hook
  (org-mode . org-roam-db-autosync-mode))

(use-package org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
		org-roam-ui-follow t
		org-roam-ui-update-on-save t
		org-roam-ui-open-on-start t))

(use-package plantuml-mode)


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
