(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)                  ; Allows cycling through candidates
  (corfu-auto t)                   ; Enable auto completion
  (corfu-auto-prefix 2)            ; Enable auto completion
  (corfu-auto-delay 0.1)           ; Enable auto completion
  (corfu-quit-at-boundary 'separator)
  (corfu-echo-documentation 0.25)   ; Enable auto completion
  (corfu-preview-current 'insert)   ; Do not preview current candidate
  (corfu-preselect-first nil)

  ;; Optionally use TAB for cycling, default is `corfu-complete'.
  :bind (:map corfu-map
              ("M-SPC" . corfu-insert-separator)
              ("TAB"     . corfu-complete)
              ([tab]     . corfu-complete)
              ("S-TAB"   . corfu-reset)
              ([backtab] . corfu-reset)
              ("S-<return>" . corfu-insert)
			  ("DEL" . corfu-quit)
              ("RET" . nil)
			  ([remap evil-complete-next] . corfu-next)
			  ([remap evil-complete-previous] . corfu-previous)
			  ([remap evil-force-normal-state] . corfu-quit)
              )

  :init
  (global-corfu-mode)
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
  :bind (("C-c p p" . completion-at-point) ;; capf
         ("C-c p t" . complete-tag)        ;; etags
         ("C-c p d" . cape-dabbrev)        ;; or dabbrev-completion
         ("C-c p h" . cape-history)
         ("C-c p f" . cape-file)
         ("C-c p k" . cape-keyword)
         ("C-c p s" . cape-symbol)
         ("C-c p a" . cape-abbrev)
         ("C-c p i" . cape-ispell)
         ("C-c p l" . cape-line)
         ("C-c p w" . cape-dict)
         ("C-c p \\" . cape-tex)
         ("C-c p _" . cape-tex)
         ("C-c p ^" . cape-tex)
         ("C-c p &" . cape-sgml)
         ("C-c p r" . cape-rfc1345))
  :init
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  ;;(add-to-list 'completion-at-point-functions #'cape-history)
  ;;(add-to-list 'completion-at-point-functions #'cape-keyword)
  ;;(add-to-list 'completion-at-point-functions #'cape-tex)
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
  ;; (add-to-list 'completion-at-point-functions #'cape-rfc1345)
  ;; (add-to-list 'completion-at-point-functions #'cape-abbrev)
  ;;(add-to-list 'completion-at-point-functions #'cape-ispell)
  ;;(add-to-list 'completion-at-point-functions #'cape-dict)
  ;;(add-to-list 'completion-at-point-functions #'cape-symbol)
  ;;(add-to-list 'completion-at-point-functions #'cape-line)
  (add-hook 'org-mode-hook (lambda ()
							 (add-to-list 'completion-at-point-functions #'cape-dabbrev)
							 (add-to-list 'completion-at-point-functions #'cape-file)
							 ))
  )

(use-package vertico
  :init (vertico-mode)
  :bind (:map vertico-map
			  ("C-n" . vertico-next)
			  ("C-p" . vertico-previous)
			  ("?" . #'minibuffer-completion-help))
  :custom
  (vertico-count 10))

(use-package orderless
  :custom
  (completion-styles '(substring basic orderless))
  )

(use-package consult
  :bind
  ("C-s" . consult-line)
  ("C-x b" . consult-buffer)
  ("C-c C-f" . consult-recent-file)
  ("C-c s r" . consult-ripgrep))

(use-package marginalia
  :bind (:map minibuffer-local-map
			  ("M-A" . marginalia-cycle))
  :init 
  (marginalia-mode))

(use-package embark
  :bind
  ("M-'" . embark-act)         ;; pick some comfortable binding
  ("M-;" . embark-dwim)        ;; good alternative: M-.
  ("C-h B" . embark-bindings) ;; alternative for `describe-bindings'
  (:map embark-meta-map
		("<f1>" . yzs/open-directory)
		("<f2>" . yzs/open-file-in-system))
  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
			   '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
				 nil
				 (window-parameters (mode-line-format . none)))))

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
  :hook
  (org-mode . yas-minor-mode)
  (js-mode . yas-minor-mode)
  (css-mode . yas-minor-mode)
  (web-mode . yas-minor-mode)
  (typescript-mode . yas-minor-mode)
  )

(use-package yasnippet-snippets
  :after yasnippet)

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap
  ("C-x p" . projectile-command-map))

;;目录树
(use-package treemacs
  :config
  (defun treemacs-toggle () 
	(interactive)
	(if (equal major-mode #'treemacs-mode)
		(treemacs-quit)
	  (treemacs-select-window)))
  (setq treemacs-width 28)
  :bind
  ("<f12>" . treemacs-toggle))

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

(use-package magit)
(use-package git-gutter
  :init (global-git-gutter-mode +1))
(use-package diff-hl
  :init
  (global-diff-hl-mode))

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
  (popper-echo-mode +1))

(provide 'emacs-better-config)
