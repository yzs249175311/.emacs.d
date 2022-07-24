(use-package vertico
  :init (vertico-mode)
  :bind (:map vertico-map
              ("C-n" . vertico-next)
              ("C-p" . vertico-previous))
  :config 
  (setq vertico-count 10))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package consult
  :bind
  ("C-s" . consult-line)
  ("C-x b" . consult-buffer)
  ("C-c C-f" . consult-recent-file)
  ("C-c f s" . consult-ripgrep)
  ("C-c e u" . consult-flymake))

(use-package marginalia
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init 
  (marginalia-mode))

(use-package embark
  :bind
  (("M-'" . embark-act)         ;; pick some comfortable binding
   ("M-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
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
  :bind
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; (defun treemacs-toggle () 
;;   (interactive)
;;   (if (equal major-mode #'treemacs-mode)
;;                    (treemacs-quit)
;;                  (treemacs-select-window)))

(use-package treemacs
  :init 
  (defun treemacs-toggle () 
    (interactive)
    (if (equal major-mode #'treemacs-mode)
        (treemacs-quit)
      (treemacs-select-window)))
  :bind
  ("<f12>" . treemacs-toggle))


(use-package rainbow-delimiters
  :hook
  (web-mode . rainbow-delimiters-mode)
  (html-mode . rainbow-delimiters-mode)
  (css-mode . rainbow-delimiters-mode)
  (js-mode . rainbow-delimiters-mode)
  (emacs-lisp-mode . rainbow-delimiters-mode)
  )


(provide 'emacs-basic-config)
