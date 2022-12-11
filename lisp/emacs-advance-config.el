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

(provide 'emacs-advance-config)
