(use-package general)

(general-define-key
 :states '(motion normal emacs insert)
 "<f5>" '(:which-key "Run")
 "<f5> r" 'yzs/run-code
 "<f5> d" 'yzs/run-code-deamon
 "SPC" '(:which-key "Custom-Key")
 )

(general-define-key
 :prefix "SPC"
 :states '(normal motion)
 :map 'global-map
 "SPC" 'execute-extended-command
 "b b" 'consult-buffer
 "b p" 'consult-project-buffer
 "b k" 'kill-current-buffer
 "b K" 'kill-buffer-and-window
 "b B" 'list-buffers
 "c" '(:which-key "Custom")
 ;; "c b" 'yzs/open-file-in-browser
 "c d" 'yzs/open-directory
 "c c" 'yzs/run-code
 "c s" 'yzs/open-file-in-live-server
 "c o" 'yzs/open-file-in-system
 "c p" 'yzs/toggle-proxy
 "c t" 'google-translate-at-point
 "c T" 'google-translate-query-translate
 "f" '(:which-key "File")
 "f f" 'find-file
 "f r" 'recentf
 "f s" 'save-buffer
 "f h" 'yzs/open-init
 "g" '(:which-key "Git")
 "g g" 'magit
 "g n" 'git-gutter:next-hunk
 "g p" 'git-gutter:previous-hunk
 "g r" 'git-gutter:revert-hunk
 "g s" 'git-gutter:stage-hunk
 "g =" 'git-gutter:popup-hunk
 "l" '(:keymap lsp-command-map :package lsp-mode :wk "Lsp")
 ;; "l a" '(:which-key "Action")
 ;; "l a r" 'lsp-bridge-rename
 ;; "l a a" 'lsp-bridge-code-action
 ;; "l a f" 'lsp-bridge-code-format
 ;; "l e" '(:which-key "Error")
 ;; "l e n" 'lsp-bridge-diagnostic-jump-next
 ;; "l e p" 'lsp-bridge-diagnostic-jump-prev
 ;; "l e l" 'lsp-bridge-diagnostic-list
 ;; "l f" '(:which-key "Find")
 ;; "l f d" 'lsp-bridge-find-def
 ;; "l f r" 'lsp-bridge-find-references
 ;; "l f i" 'lsp-bridge-find-impl
 ;; "l s" '(:which-key "Show")
 ;; "l s d" 'lsp-bridge-popup-documentation
 "o" '(:which-key "Org")
 "o f" 'org-roam-node-find
 "o i" 'org-roam-node-insert
 "o t" 'org-roam-buffer-toggle
 "o c" 'org-id-get-create
 "o g" 'org-roam-ui-mode
 "o s" 'org-roam-db-sync
 "o r" 'org-redisplay-inline-images
 "o a" 'org-agenda-list
 "o A" 'org-agenda
 "p" '(:keymap projectile-command-map :which-key "Projectile" :package projectile)
 "s" '(:which-key "Switch-Search")
 "s r" 'consult-ripgrep
 "s g" 'consult-grep
 "s m" 'consult-bookmark
 "s i" 'consult-imenu
 "s t" 'consult-theme
 "s b" 'consult-buffer
 "t" '(:keymap tab-prefix-map :which-key "Tab")
 "w" '(:keymap evil-window-map :which-key "Window") 
 "&" '(:keymap yas-minor-mode-map :which-key "Yasnippet")
 )


;; evil global
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
 :prefix "g"
 :states '(motion normal)
 "." 'repeat
 "c c" 'comment-line
 )

;; dired 
(general-define-key
 :states '(motion normal)
 :keymaps 'dired-mode-map
 "h" 'dired-up-directory
 "l" 'dired-find-file
 )

;; org
(general-define-key
 :prefix "SPC"
 :states '(motion normal)
 :keymaps '(org-agenda-mode-map)
 "m" '(:keymap org-agenda-mode-map :which-key "Major")
 )

;;yasnippet
(general-define-key
 :prefix "SPC"
 :states '(motion normal)
 :keymaps 'yas-minor-mode-map
 "& i" 'yas-insert-snippet
 "& n" 'yas-new-snippet
 "& v" 'yas-visit-snippet-file
 )

(provide 'emacs-key-binding-config)
