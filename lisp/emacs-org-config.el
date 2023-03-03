(use-package org
  :init
  (let ((dir "~/Nutstore Files/note/GTD/"))
	(if (file-exists-p dir)
	  (setq yzs/org-agenda-files (directory-files dir t ".org$"))
	  (setq yzs/org-agenda-files nil)
	  ))
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
		org-insert-heading-respect-content t

		org-hide-emphasis-markers nil
		;; org-ellipsis " ⤵"
		org-ellipsis "…"
		org-pretty-entities nil
		;; Agenda styling
		org-agenda-tags-column 0
		org-agenda-block-separator ?─
		org-agenda-time-grid
		'((daily today require-timed)
		  (800 1000 1200 1400 1600 1800 2000)
		  " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
		org-agenda-current-time-string
		"⭠ now ─────────────────────────────────────────────────"
		org-plantuml-jar-path (expand-file-name "~/.emacs.d/.cache/org-uml/plantuml.jar")
		;; org-html-head-include-default-style nil

		;; org-html-head-extra "<style>
		;; 							pre.src{background:#343131;color:white;}
		;; 							#content{max-width:1800px;}
		;; 							p{max-width:1600px;}
		;; 							li{max-width:1600px;}
		;; 					  </style>"

		)


  (setq org-refile-targets '(
							 (nil :maxlevel . 2)
							 (org-agenda-files :maxlevel . 2)
							 ))

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

  ;; org open file by app
  (setq org-file-apps (reverse (append org-file-apps
									   `(("\\.epub\\'" . ,yzs/org/org-open-file)
										 ("\\.pdf\\'" . ,yzs/org/org-open-file)
										 ))))

  :hook 
  (org-mode . org-indent-mode)
  (org-babel-after-execute . org-redisplay-inline-images)

  :custom
  (org-enforce-todo-dependencies t)
  (org-track-ordered-property-with-tag t)
  (org-capture-templates 
   '(("r" "Read Books")
	 ("rb" "Books" entry (file+olp "d:/NutStore/note/GTD/read.org" "读书目录")
	  "\n** TODO %^{Book name} - %^{Author}" :kill-buffer t)))
  (org-agenda-files yzs/org-agenda-files))

(use-package htmlize)

(use-package ox-reveal
  :config
  (setq org-reveal-hlevel 2))

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
(use-package cdlatex
  :hook
  (org-mode . #'turn-on-org-cdlatex)
  (LaTeX-mode . #'turn-on-cdlatex)
  :bind
  (:map cdlatex-mode-map
		("TAB" . nil)
		("C-<return>" . nil)))
(use-package auctex)

;; add "#+setupfile:" to every .org buffer
(defcustom yzs/setup-file '("https://yzs249175311.github.io/org-html-theme-dull/org-html-theme-dull.setup")
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

(add-hook 'org-export-before-processing-hook 'yzs/org-export-setup-files)

;; end

(provide 'emacs-org-config)
