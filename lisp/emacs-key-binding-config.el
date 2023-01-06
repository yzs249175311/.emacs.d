(use-package general)

(general-define-key
 :states '(motion normal emacs insert)
 "<f5>" 'yzs/run-code
 )
(general-define-key
 :states '(normal motion)
 "SPC" (general-simulate-key "C-c"))

(general-define-key
 :prefix "C-c"
 :states '(normal insert motion emacs)
 "b b" 'consult-buffer
 "b k" 'kill-buffer
 "b B" 'list-buffers
 "c" '(:which-key "Custom")
 ;; "c b" 'yzs/open-file-in-browser
 "c d" 'yzs/open-directory
 "c c" 'yzs/run-code
 "c s" 'yzs/open-file-in-live-server
 "c o" 'yzs/open-file-in-system
 "f" '(:which-key "File")
 "f f" 'find-file
 "f r" 'recentf-open-files
 "g" '(:which-key "Git")
 "g g" 'magit
 "g n" 'diff-hl-next-hunk
 "g p" 'diff-hl-previous-hunk
 "g r" 'diff-hl-revert-hunk
 "g s" 'diff-hl-stage-current-hunk
 "g v" 'diff-hl-show-hunk
 "o" '(:which-key "Org")
 "o f" 'org-roam-node-find
 "o i" 'org-roam-node-insert
 "o t" 'org-roam-buffer-toggle
 "o c" 'org-id-get-create
 "o g" 'org-roam-ui-mode
 "o s" 'org-roam-db-sync
 "o r" 'org-redisplay-inline-images
 "o a" 'org-agenda
 "p" '(:keymap projectile-command-map :which-key "Projectile" :package projectile)
 "s" '(:which-key "Search-Switch")
 "s r" 'consult-ripgrep
 "s g" 'consult-grep
 "s m" 'consult-bookmark
 "s i" 'consult-imenu
 "s t" 'consult-theme
 "t" '(:keymap tab-prefix-map :which-key "Tab" :package projectile)
 "w" '(:keymap evil-window-map :which-key "Window") 
 )

(general-define-key
 :states '(normal insert motion emacs)
 "C-M-<left>" 'evil-window-decrease-width
 "C-M-<right>" 'evil-window-increase-width
 "C-M-<up>" 'evil-window-increase-height
 "C-M-<down>" 'evil-window-decrease-height
 )

(general-define-key
 :states '(normal motion)
 ")" 'evil-paste-pop-next
 "(" 'evil-paste-pop
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
 "+" 'evil-numbers/inc-at-pt
 "-" 'evil-numbers/dec-at-pt
 "c c" 'comment-line
 )

(general-define-key
 :prefix "g"
 :states '(motion normal)
 :keymap 'lsp-mode-map
 "l r" 'lsp-ui-peek-find-references
 "l e" 'lsp-treemacs-errors-list
 "d" 'lsp-ui-peek-find-definitions
 "! l" 'lsp-ui-flycheck-list
 )

(general-define-key
 :states '(motion normal)
 :keymaps 'dired-mode-map
 "h" 'dired-up-directory
 "l" 'dired-find-file
 )

(provide 'emacs-key-binding-config)
