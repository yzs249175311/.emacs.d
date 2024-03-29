;;; emacs-evil-config.el --- setup build-in package config -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:
(defun yzs/evil-init ()
  (setq evil-undo-system 'undo-redo)
  (setq evil-want-C-i-jump nil)
	(setq evil-want-C-u-scroll t)
	(cond
	 ((string-equal system-type "windows-nt")
		(add-hook 'evil-normal-state-entry-hook (lambda () (w32-set-ime-open-status nil))))

   ((string-equal system-type "gnu/linux")

		(cond
		 ((executable-find "fcitx5-remote")
			(add-hook 'evil-normal-state-entry-hook (lambda () (call-process "fcitx5-remote" nil 0 nil "-c"))))
		 ))))

(defun yzs/evil-config ()
  (setq evil-motion-state-modes
				(append '(
									treemacs-mode
									magit-status-mode
									lsp-treemacs-error-list-mode
									)
								evil-emacs-state-modes
								evil-motion-state-modes))
  (setq evil-emacs-state-modes nil)
  ;; (setq evil-motion-state-modes nil)
  (setq evil-normal-state-modes
				(append evil-normal-state-modes
								evil-motion-state-modes
								'(
									occur-mode
									occur-edit-mode
									grep-mode
									shell-mode
									helpful-mode
									)))
  (setq avy-all-windows nil
				avy-background t)
	(setq evil-emacs-state-cursor 'bar)
  (define-key evil-normal-state-map (kbd "SPC") (lookup-key evil-motion-state-map (kbd "SPC")))
  (define-key evil-motion-state-map (kbd "SPC") nil)
  (define-key evil-normal-state-map (kbd "RET") (lookup-key evil-motion-state-map (kbd "RET")))
  (define-key evil-motion-state-map (kbd "RET") nil)
  )

(use-package evil
  :defer nil
  :init
  (yzs/evil-init)
  :config
  (evil-mode)
  (yzs/evil-config)
  :bind
	(:map evil-insert-state-map
				("C-n" . nil)
				("C-p" . nil)
				("C-e" . nil)
				("C-a" . nil)
				("C-y" . nil)
				("C-d" . nil)
				("C-k" . nil)
				)
	(:map evil-emacs-state-map
				("<escape>" . evil-normal-state))
	(:map evil-motion-state-map
				("RET" . nil))
	(:map evil-window-map
				("q" . evil-delete-buffer))
	(:map evil-normal-state-map
				("s" . nil)
				("s f" . evil-avy-goto-char-2)
				("s j" . evil-avy-goto-line)
				("s k" . evil-avy-goto-line)
				("s s" . evil-avy-goto-char-timer)
				("g r" . xref-find-references)
				("g c c" . comment-line)
				("C-S-o" . evil-jump-forward))
	:custom
	(evil-shift-width 2)
	)

(use-package evil-surround
  :after evil
  :init
  (global-evil-surround-mode 1)
  )

;; (use-package evil-mc
;;   :after evil
;;   :init
;;   (global-evil-mc-mode 1)
;;   )

(use-package evil-multiedit
  :after evil
  :commands (evil-multiedit-default-keybinds)
  :init
  (evil-multiedit-default-keybinds)
  )

(use-package  evil-escape
  :after evil
  :init
  ;; (setq-default evil-escape-key-sequence "jk")
  (setq-default evil-escape-delay 0.2)
  (evil-escape-mode)
  )

(use-package evil-matchit
  :after evil
  :init
  (global-evil-matchit-mode 1))



(provide 'emacs-evil-config)

;;; emacs-evil-config.el ends here
