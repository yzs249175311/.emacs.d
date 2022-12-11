(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)                  ; Allows cycling through candidates
  (corfu-auto t)                   ; Enable auto completion
  (corfu-auto-prefix 2)            ; Enable auto completion
  (corfu-auto-delay 0.1)           ; Enable auto completion
  (corfu-quit-at-boundary nil)
  (corfu-echo-documentation 0.25)   ; Enable auto completion
  (corfu-preview-current 'insert)   ; Do not preview current candidate
  (corfu-preselect-first nil)

  ;; Optionally use TAB for cycling, default is `corfu-complete'.
  :bind (:map corfu-map
              ("M-SPC" . corfu-insert-separator)
              ("TAB"     . corfu-complete)
              ([tab]     . corfu-complete)
              ("S-TAB"   . corfu-reset)
              ([backtab] . corfu-reset)
              ("S-<return>" . corfu-insert)
              ("RET" . nil)
			  ([remap evil-complete-next] . corfu-next)
			  ([remap evil-complete-previous] . corfu-previous)
			  ([remap evil-force-normal-state] . corfu-quit)
              )

  :init
  (global-corfu-mode)
  (defun corfu-enable-always-in-minibuffer ()
	"Enable Corfu in the minibuffer if Vertico/Mct are not active."
	(unless (or (bound-and-true-p mct--active)
				(bound-and-true-p vertico--input))
	  ;; (setq-local corfu-auto nil) Enable/disable auto completion
	  (corfu-mode 1)))
  (add-hook 'minibuffer-setup-hook #'corfu-enable-always-in-minibuffer 1) (corfu-history-mode)
  :config
  (add-hook 'eshell-mode-hook
			(lambda () (setq-local corfu-quit-at-boundary t
								   corfu-quit-no-match t
								   corfu-auto nil)
			  (corfu-mode))))

(use-package cape
  ;; Bind dedicated completion commands
  ;; Alternative prefix keys: C-c p, M-p, M-+, ...
  :bind (("C-c p p" . completion-at-point) ;; capf
         ("C-c p t" . complete-tag)        ;; etags
         ("C-c p d" . cape-dabbrev)        ;; or dabbrev-completion
         ("C-c p h" . cape-history)
         ("C-c p f" . cape-file)
         ("C-c p k" . cape-keyword)
         ("C-c p s" . cape-symbol)
         ("C-c p a" . cape-abbrev)
         ("C-c p i" . cape-ispell)
         ("C-c p l" . cape-line)
         ("C-c p w" . cape-dict)
         ("C-c p \\" . cape-tex)
         ("C-c p _" . cape-tex)
         ("C-c p ^" . cape-tex)
         ("C-c p &" . cape-sgml)
         ("C-c p r" . cape-rfc1345))
  :init
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  ;;(add-to-list 'completion-at-point-functions #'cape-history)
  ;;(add-to-list 'completion-at-point-functions #'cape-keyword)
  ;;(add-to-list 'completion-at-point-functions #'cape-tex)
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
  ;; (add-to-list 'completion-at-point-functions #'cape-rfc1345)
  ;; (add-to-list 'completion-at-point-functions #'cape-abbrev)
  ;;(add-to-list 'completion-at-point-functions #'cape-ispell)
  ;;(add-to-list 'completion-at-point-functions #'cape-dict)
  ;;(add-to-list 'completion-at-point-functions #'cape-symbol)
  ;;(add-to-list 'completion-at-point-functions #'cape-line)
  (add-hook 'org-mode-hook (lambda ()
							 (add-to-list 'completion-at-point-functions #'cape-dabbrev)
							 (add-to-list 'completion-at-point-functions #'cape-file)
							 ))
  )

(use-package flycheck
  :init
  (global-flycheck-mode 1))

;; (use-package company
;;   :hook
;;   (after-init . global-company-mode)

;;   ;; (web-mode . (lambda ()
;;   ;;               (add-to-list 'company-backends 'company-web-html)
;;   ;; 				(add-to-list 'company-backends 'company-yasnippet)
;;   ;; 				))
;;   :bind
;;   (:map company-mode-map
;;         ("C-M-i" . company-complete)
;; 		("C-M-/" . company-dabbrev-code))
;;   (:map company-active-map
;; 		([remap evil-normal-state] . company-abort))
;;   :config
;;   (setq company-minimum-prefix-length 3))

;; (use-package company-web)

(use-package yasnippet
  :hook
  (org-mode . yas-minor-mode)
  (js-mode . yas-minor-mode)
  (css-mode . yas-minor-mode)
  (web-mode . yas-minor-mode)
  (typescript-mode . yas-minor-mode)
  )

(use-package yasnippet-snippets
  :after yasnippet)

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap
  ("C-x p" . projectile-command-map))

(use-package yaml-mode)

(require 'code-web)
(require 'code-lsp)

(provide 'emacs-code-config)
