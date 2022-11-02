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
 :keymaps 'global-map
 "c" '(:which-key "Custom")
 "o" '(:which-key "Org")
 "!" '(:which-key "check")
 )

(general-define-key
 :prefix "g"
 :states '(normal motion)
 "c c" 'comment-line
 )

(general-define-key
 :states '(normal insert motion emacs)
 "C-M-<left>" 'evil-window-decrease-width
 "C-M-<right>" 'evil-window-increase-width
 "C-M-<up>" 'evil-window-increase-height
 "C-M-<down>" 'evil-window-decrease-height
 )

;;Org
(general-define-key
 :states '(normal insert motion emacs)
 :prefix "C-c o"
 "f" 'org-roam-node-find
 "i" 'org-roam-node-insert
 "t" 'org-roam-buffer-toggle
 "c" 'org-id-get-create
 "g" 'org-roam-ui-mode
 "s" 'org-roam-db-sync
 "r" 'org-redisplay-inline-images
 )

;; Custom
(general-define-key
 :states '(normal insert motion emacs)
 :prefix "C-c c"
 "b" 'yzs/open-file-in-browser
 "d" 'yzs/open-directory
 "c" 'yzs/run-code
 "s" 'yzs/open-file-in-live-server
 "o" 'yzs/open-file-in-system
 )

(provide 'emacs-key-binding-config)
