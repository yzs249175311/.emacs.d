(defun yzs/evil-init ()
  (setq evil-want-C-i-jump nil)
  (setq evil-undo-system 'undo-redo)
  (setq evil-want-C-u-scroll t)
  (cond 
   ((string-equal system-type "windows-nt") 
	(add-hook 'evil-normal-state-entry-hook (lambda () (w32-set-ime-open-status nil))))

   ((string-equal system-type "gnu/linux")
	(cond
	 ((yzs/program-exists-p "fcitx5-remote" exec-path)
	  (add-hook 'evil-normal-state-entry-hook (lambda () (call-process "fcitx5-remote" nil 0 nil "-c"))))
	 ))))

(defun yzs/evil-config () 
  (setq evil-motion-state-modes 
		(append '( 
				  treemacs-mode 
				  magit-status-mode
				  helpful-mode
				  lsp-treemacs-error-list-mode
				  ) 
				evil-emacs-state-modes
				evil-motion-state-modes))
  (setq evil-emacs-state-modes nil)
  (setq evil-normal-state-modes
		(append evil-normal-state-modes
				'(
				  grep-mode
				  shell-mode
				  )))
  )

(use-package evil
  :defer nil
  :init 
  (yzs/evil-init)
  :config
  (evil-mode)
  (yzs/evil-config)
  :bind
  (:map evil-window-map
		("q" . evil-delete-buffer))
  (:map evil-motion-state-map
		("RET" . nil))

  (:map evil-normal-state-map
		("s" . nil)
		("s f" . evil-avy-goto-char-2)
		("s j" . evil-avy-goto-line)
		("s k" . evil-avy-goto-line)
		("s s" . evil-avy-goto-char-timer)
		(")" . evil-paste-pop-next)
		("(" . evil-paste-pop)
		("g" . nil)
		("g c c" . comment-line))
  )

(use-package evil-surround
  :init
  (global-evil-surround-mode 1))

(use-package evil-mc
  :after evil
  :init
  (global-evil-mc-mode 1) 
  )

(use-package  evil-escape
  :init
  ;; (setq-default evil-escape-key-sequence "jk")
  (setq-default evil-escape-delay 0.2)
  (evil-escape-mode)
  )

(use-package evil-matchit
  :init
  (global-evil-matchit-mode 1))



(provide 'emacs-evil-config)
