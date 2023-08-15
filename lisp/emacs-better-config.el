(use-package company
  :if (null (display-graphic-p))
  :init
  (setq orderless-component-separator "[ &]")
  :hook
  (after-init . global-company-mode)
  :bind
  (:map company-mode-map
		("C-M-i" . company-complete)
		("C-M-/" . company-dabbrev-code))
  (:map company-active-map
		([remap evil-normal-state] . company-abort)
		("TAB" . company-complete-selection)
		("<tab>" . company-complete-selection)
		("C-h" . nil)
		("RET" . nil)
		("<return>" . nil))
  :config
  (setq company-minimum-prefix-length 2))

(use-package corfu
  :if (display-graphic-p)
  ;; Optional customizations
  :custom
  (corfu-cycle t)                  ; Allows cycling through candidates
  (corfu-auto t)                   ; Enable auto completion
  (corfu-auto-prefix 2)            ; Enable auto completion
  (corfu-auto-delay 0.5)           ; Enable auto completion
  (corfu-quit-at-boundary 'separator)
  (corfu-echo-documentation 0.25)   ; Enable auto completion
  (corfu-preview-current 'insert)   ; Do not preview current candidate
  (corfu-preselect-first t)

  ;; Optionally use TAB for cycling, default is `corfu-complete'.
  :bind (:map corfu-map
			  ("M-SPC" . corfu-insert-separator)
			  ("TAB"     . corfu-complete)
			  ([tab]     . corfu-complete)
			  ("S-TAB"   . corfu-reset)
			  ([backtab] . corfu-reset)
			  ("S-<return>" . corfu-insert)
			  ;; ("DEL" . corfu-quit)
			  ("RET" . nil)
			  ([remap evil-complete-next] . corfu-next)
			  ([remap evil-complete-previous] . corfu-previous)
			  ([remap evil-force-normal-state] . corfu-quit)
			  )

  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode)
  (defun corfu-enable-always-in-minibuffer ()
	"Enable Corfu in the minibuffer if Vertico/Mct are not active."
	(unless (or (bound-and-true-p mct--active)
				(bound-and-true-p vertico--input))
	  ;; (setq-local corfu-auto nil) Enable/disable auto completion
	  (corfu-mode 1)))
  (add-hook 'minibuffer-setup-hook #'corfu-enable-always-in-minibuffer 1) (corfu-history-mode)
  :config
  (add-hook 'eshell-mode-hook
			(lambda () (setq-local corfu-quit-at-boundary t
								   corfu-quit-no-match t
								   corfu-auto nil)
			  (corfu-mode))))

(use-package cape
  ;; Bind dedicated completion commands
  ;; Alternative prefix keys: C-c p, M-p, M-+, ...
  :bind (
		 ;; ("C-c p p" . completion-at-point) ;; capf
		 ;; ("C-c p t" . complete-tag)        ;; etags
		 ;; ("C-c p d" . cape-dabbrev)        ;; or dabbrev-completion
		 ;; ("C-c p h" . cape-history)
		 ;; ("C-c p f" . cape-file)
		 ;; ("C-c p k" . cape-keyword)
		 ;; ("C-c p s" . cape-symbol)
		 ;; ("C-c p a" . cape-abbrev)
		 ;; ("C-c p i" . cape-ispell)
		 ;; ("C-c p l" . cape-line)
		 ;; ("C-c p w" . cape-dict)
		 ;; ("C-c p \\" . cape-tex)
		 ;; ("C-c p _" . cape-tex)
		 ;; ("C-c p ^" . cape-tex)
		 ;; ("C-c p &" . cape-sgml)
		 ;; ("C-c p r" . cape-rfc1345)
		 )
  :init
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  ;; (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  ;;(add-to-list 'completion-at-point-functions #'cape-history)
  ;; (add-to-list 'completion-at-point-functions #'cape-keyword)
  ;;(add-to-list 'completion-at-point-functions #'cape-tex)
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
  ;; (add-to-list 'completion-at-point-functions #'cape-rfc1345)
  ;; (add-to-list 'completion-at-point-functions #'cape-abbrev)
  ;;(add-to-list 'completion-at-point-functions #'cape-ispell)
  ;;(add-to-list 'completion-at-point-functions #'cape-dict)
  ;; (add-to-list 'completion-at-point-functions #'cape-symbol)
  ;;(add-to-list 'completion-at-point-functions #'cape-line)
  (add-hook 'org-mode-hook (lambda ()
							 (add-to-list 'completion-at-point-functions #'cape-dabbrev)
							 (add-to-list 'completion-at-point-functions #'cape-file)
							 ))
  )

(use-package vertico
  :init
  (vertico-mode)
  :bind (:map vertico-map
			  ("C-n" . vertico-next)
			  ("C-p" . vertico-previous)
			  ("M-n" . vertico-next)
			  ("M-p" . vertico-previous))
  :custom
  (vertico-count 10))

(use-package vertico-posframe
  :if (display-graphic-p)
  :init
  (vertico-posframe-mode 1))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
		completion-category-defaults nil
		completion-category-overrides '((file (styles . (partial-completion)))))
  :custom
  (orderless-matching-styles '(orderless-prefixes orderless-literal orderless-regexp ))
  )

(use-package consult
  :init
  (setq xref-show-xrefs-function #'consult-xref
		xref-show-definitions-function #'consult-xref)
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))
  :bind
  (("C-c M-x" . consult-mode-command)
   ("C-c h" . consult-history)
   ("C-c k" . consult-kmacro)
   ("C-c m" . consult-man)
   ("C-c i" . consult-info)
   ([remap Info-search] . consult-info)
   ;; C-x bindings (ctl-x-map)
   ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
   ([remap switch-to-buffer] . consult-buffer) ;; orig. switch-to-buffer
   ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
   ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
   ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
   ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
   ;; Custom M-# bindings for fast register access
   ;; ("M-#" . consult-register-load)
   ;; ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
   ;; ("C-M-#" . consult-register)
   ;; Other custom bindings
   ("M-y" . consult-yank-pop)                ;; orig. yank-pop
   ;; M-g bindings (goto-map)
   ("M-g e" . consult-compile-error)
   ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
   ("M-g g" . consult-goto-line)             ;; orig. goto-line
   ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
   ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
   ("M-g m" . consult-mark)
   ("M-g k" . consult-global-mark)
   ("M-g i" . consult-imenu)
   ("M-g I" . consult-imenu-multi)
   ;; M-s bindings (search-map)
   ("M-s d" . consult-find)
   ("M-s D" . consult-locate)
   ("M-s g" . consult-grep)
   ("M-s G" . consult-git-grep)
   ("M-s r" . consult-ripgrep)
   ("M-s l" . consult-line)
   ("M-s L" . consult-line-multi)
   ("M-s k" . consult-keep-lines)
   ("M-s u" . consult-focus-lines)
   ([remap isearch-forward] . consult-line)
   ("M-s L" . consult-line-multi)
   ("M-s k" . consult-keep-lines)
   ("M-s u" . consult-focus-lines)
   ;; Isearch integration
   ("M-s e" . consult-isearch-history)
   :map isearch-mode-map
   ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
   ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
   ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
   ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
   ;; Minibuffer history
   :map minibuffer-local-map
   ("M-s" . consult-history)                 ;; orig. next-matching-history-element
   ("M-r" . consult-history))                ;; orig. previous-matching-history-element
  )
(use-package consult-yasnippet)

(use-package marginalia
  :bind
  (:map minibuffer-local-map
		("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

(use-package embark
  :bind
  ("M-'" . embark-act)         ;; pick some comfortable binding
  ("M-;" . embark-dwim)        ;; good alternative: M-.
  ("C-h B" . embark-bindings) ;; alternative for `describe-bindings'
  (:map embark-region-map
		("SPC" . nil))
  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
			   '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
				 nil
				 (window-parameters (mode-line-format . none))))

  (defun embark-which-key-indicator ()
	"An embark indicator that displays keymaps using which-key.
The which-key help message will show the type and value of the
current target followed by an ellipsis if there are further
targets."
	(lambda (&optional keymap targets prefix)
	  (if (null keymap)
		  (which-key--hide-popup-ignore-command)
		(which-key--show-keymap
		 (if (eq (plist-get (car targets) :type) 'embark-become)
			 "Become"
		   (format "Act on %s '%s'%s"
				   (plist-get (car targets) :type)
				   (embark--truncate-target (plist-get (car targets) :target))
				   (if (cdr targets) "…" "")))
		 (if prefix
			 (pcase (lookup-key keymap prefix 'accept-default)
			   ((and (pred keymapp) km) km)
			   (_ (key-binding prefix 'accept-default)))
		   keymap)
		 nil nil t (lambda (binding)
					 (not (string-suffix-p "-argument" (cdr binding))))))))

  (setq embark-indicators
		'(embark-which-key-indicator
		  embark-highlight-indicator
		  embark-isearch-highlight-indicator))

  (defun embark-hide-which-key-indicator (fn &rest args)
	"Hide the which-key indicator immediately when using the completing-read prompter."
	(which-key--hide-popup-ignore-command)
	(let ((embark-indicators
		   (remq #'embark-which-key-indicator embark-indicators)))
	  (apply fn args)))

  (advice-add #'embark-completing-read-prompter
			  :around #'embark-hide-which-key-indicator)
  )

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :after (embark consult)
  :demand t ; only necessary if you have the hook below
  ;; if you want to have consult previews as you move around an
  ;; auto-updating embark collect buffer
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package wgrep
  :init
  (setq wgrep-auto-save-buffer t))


(use-package yasnippet
  :init
  (yas-global-mode 1)
  :hook
  ;; (prog-mode . yas-global-mode)
  (lsp-mode . yas-minor-mode-on)
  (org-mode . yas-minor-mode-on)
  )

(use-package yasnippet-snippets
  :after yasnippet)

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode))

;;目录树
(use-package treemacs
  :config
  (defun treemacs-toggle ()
	(interactive)
	(if (equal major-mode 'treemacs-mode)
		(treemacs-quit)
	  (treemacs-select-window)))
  (setq treemacs-width 35)

  :bind
  ("<f12>" . treemacs-toggle)
  )
(use-package treemacs-evil
  :hook
  (treemacs-mode . evil-treemacs-state)
  )

(use-package which-key
  :init
  (setq which-key-show-early-on-C-h t
		which-key-idle-delay 1)
  (which-key-mode))

(use-package helpful
  :bind
  ([remap describe-function] . helpful-function)
  ([remap describe-key] . helpful-key)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-command] . helpful-command)
  ([remap describe-symbol] . helpful-symbol)
  )

(use-package magit
  ;; :hook
  ;; (magit-status-mode . (lambda ()
  ;; 							 (evil-define-key 'motion magit-status-mode-map (kbd "?") 'magit-dispatch)))
  )

(use-package git-gutter
  ;; :init (global-git-gutter-mode +1)
  :hook
  (find-file . git-gutter-mode)
  :custom
  (git-gutter:window-width 1)
  ;; (git-gutter:modified-sign "☁")
  ;; (git-gutter:added-sign "☀")
  ;; (git-gutter:deleted-sign "☂")
  )

(use-package popper
  :bind (("C-`"   . popper-toggle-latest)
		 ("M-`"   . popper-cycle)
		 ("C-M-`" . popper-toggle-type))
  :init
  (setq popper-reference-buffers
		'("\\*Messages\\*"
		  "Output\\*$"
		  "\\*Async Shell Command\\*"
		  "\\*Completions\\*"
		  help-mode
		  compilation-mode
		  helpful-mode
		  compilation-mode
		  "^\\*eshell.*\\*$" eshell-mode
		  "^\\*shell.*\\*$"  shell-mode
		  "^\\*term.*\\*$"   term-mode
		  "^\\*vterm.*\\*$"  vterm-mode ))

  (popper-mode +1)
  (popper-echo-mode +1)
  :custom
  (popper-window-height (lambda (win)
						  (fit-window-to-buffer
						   win
						   (floor (frame-height) 2)
						   (floor (frame-height) 3)
						   ))))

(use-package popwin
  :init
  (popwin-mode 1))

(use-package posframe)

;; (use-package flycheck-posframe
;;   :after flycheck
;;   :init (add-hook 'flycheck-mode-hook #'flycheck-posframe-mode))

(use-package google-translate
  :custom
  (google-translate-default-source-language "en")
  (google-translate-default-target-language "zh-CN")
  :bind
  ("C-c c t" . 'google-translate-at-point)
  ("C-c c T" . 'google-translate-query-translate)
  (:map embark-region-map
		("SPC t" . 'google-translate-at-point)))

(use-package vterm
  :bind
  (:map vterm-mode-map
		("M-;" . nil)
		("M-'" . nil)
		("M-`" . nil)))

(use-package esup)

(use-package find-file-in-project
  :bind
  (:map projectile-mode-map
		([remap projectile-find-file] . find-file-in-project)))

(use-package expand-region
  :config
  (advice-add
   'er/prepare-for-more-expansions-internal
   :filter-return (lambda (ad-return-value)
					(let ((msg (car ad-return-value))
						  (keybindings (cdr ad-return-value))
						  )
					  (setq msg (concat msg
										", l to search word in buffer"
										", f to search file"
										", r to search word in project"
										))
					  (add-to-list 'keybindings `("l" (lambda ()
														(keyboard-escape-quit)
														(consult-line (buffer-substring (region-beginning) (region-end))))))
					  (add-to-list 'keybindings `("f" (lambda ()
														(read-file-name "Find file: " (expand-file-name (buffer-substring (region-beginning) (region-end))))
														)))
					  (add-to-list 'keybindings `("r" (lambda ()
														(keyboard-escape-quit)
														(consult-ripgrep (consult--project-root (project-current)) (buffer-substring (region-beginning) (region-end)))
														)))
					  (cons msg keybindings)
					  )))
  :bind
  (:map evil-normal-state-map
		("+" . er/expand-region)
		("-" . er/contract-region)))

(provide 'emacs-better-config)
