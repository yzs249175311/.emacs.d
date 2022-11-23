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

(defun yzs/evil-key-config () 
  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-motion-state-map (kbd "?") nil)
  (define-key evil-window-map (kbd "q") 'evil-delete-buffer))

(use-package evil
  :defer nil
  :init 
  (yzs/evil-init)
  :config
  (evil-mode)
  (yzs/evil-config)
  (yzs/evil-key-config)
  ;;(define-key evil-motion-state-map (kbd "RET") nil)
  )

(use-package evil-surround
  :init
  (global-evil-surround-mode 1))

(provide 'emacs-evil-config)
