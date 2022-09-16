(use-package general)

(general-define-key
 :prefix "C-c"
 :states '(normal insert)
 :keymaps 'yas-minor-mode-map
 "y" '(:which-key "yasnippet")
 "y i" 'yas-insert-snippet
 "y t" 'yas-describe-tables
 )
 
(general-define-key
 :prefix "C-c"
 :states '(normal insert)
 :keymaps 'flycheck-mode-map
 "!" '(:which-key "check")
 )

(general-define-key
 :prefix "C-c"
 :states '(normal insert)
 :keymaps 'global-map
 "c" '(:which-key "Custom")
 )

(general-define-key
 :prefix "g"
 :states '(normal motion)
 "c c" 'comment-line
 )

(general-define-key
 :states '(normal insert motion emacs)
 "<left>" 'windmove-left
 "<right>" 'windmove-right
 "<up>" 'windmove-up
 "<down>" 'windmove-down
 "S-<left>" 'evil-window-decrease-width
 "S-<right>" 'evil-window-increase-width
 "S-<up>" 'evil-window-increase-height
 "S-<down>" 'evil-window-decrease-height
 "M-<left>" 'evil-window-move-far-left
 "M-<right>" 'evil-window-move-far-right
 "M-<up>" 'evil-window-move-very-top
 "M-<down>" 'evil-window-move-very-bottom
 )
(provide 'emacs-key-binding-config)
