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
 "<left>" 'evil-window-decrease-width
 "<right>" 'evil-window-increase-width
 "<up>" 'evil-window-increase-height
 "<down>" 'evil-window-decrease-height
 )
(provide 'emacs-key-binding-config)
