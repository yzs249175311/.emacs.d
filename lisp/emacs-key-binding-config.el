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
 "!" '(:which-key "flycheck")
 )

(provide 'emacs-key-binding-config)
