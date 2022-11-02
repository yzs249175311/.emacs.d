(use-package general)

(general-define-key
 :states '(normal insert motion emacs)
 "C-M-<left>" 'evil-window-decrease-width
 "C-M-<right>" 'evil-window-increase-width
 "C-M-<up>" 'evil-window-increase-height
 "C-M-<down>" 'evil-window-decrease-height
 )

(general-define-key
 :prefix "C-c"
 :states '(normal insert motion emacs)
 :keymaps 'global-map
 "c" '(:which-key "Custom")
 "c b" 'yzs/open-file-in-browser
 "c d" 'yzs/open-directory
 "c c" 'yzs/run-code
 "c s" 'yzs/open-file-in-live-server
 "c o" 'yzs/open-file-in-system
 "c o" '(:which-key "Org")
 "o f" 'org-roam-node-find
 "o i" 'org-roam-node-insert
 "o t" 'org-roam-buffer-toggle
 "o c" 'org-id-get-create
 "o g" 'org-roam-ui-mode
 "o s" 'org-roam-db-sync
 "o r" 'org-redisplay-inline-images
 "!" '(:which-key "Check")
 "g" '(:which-key "Git")
 "g n" 'git-gutter:next-hunk
 "g p" 'git-gutter:previous-hunk
 "g r" 'git-gutter:revert-hunk
 "g t" 'git-gutter:toggle
 "g v" 'git-gutter:popup-hunk
 )

(general-define-key
 :prefix "C-c"
 :states '(normal insert)
 :keymaps 'yas-minor-mode-map
 "y" '(:which-key "yasnippet")
 "y i" 'yas-insert-snippet
 "y t" 'yas-describe-tables
 )

(general-define-key
 :prefix "g"
 :states '(motion normal)
 "." 'repeat
 "c c" 'comment-line
 )

(provide 'emacs-key-binding-config)
