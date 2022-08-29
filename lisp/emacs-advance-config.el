(use-package vertico
  :defer nil
  :config (vertico-mode)
  :bind (:map vertico-map
              ("C-n" . vertico-next)
              ("C-p" . vertico-previous))
  :custom
  (vertico-count 10))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package consult
  :bind
  ("C-s" . consult-line)
  ("C-x b" . consult-buffer)
  ("C-c C-f" . consult-recent-file)
  ("C-c s r" . consult-ripgrep))

(use-package marginalia
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init 
  (marginalia-mode))

(use-package embark
  :bind
  ("M-'" . embark-act)         ;; pick some comfortable binding
  ("M-;" . embark-dwim)        ;; good alternative: M-.
  ("C-h B" . embark-bindings) ;; alternative for `describe-bindings'
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)
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

;;目录树
(use-package treemacs
  :config
  (defun treemacs-toggle () 
    (interactive)
    (if (equal major-mode #'treemacs-mode)
        (treemacs-quit)
      (treemacs-select-window)))
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
  )


(use-package magit)

(use-package flycheck
  :hook
  (after-init . global-flycheck-mode))

(provide 'emacs-advance-config)
