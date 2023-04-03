;;彩虹括号
(use-package rainbow-delimiters
  :hook
  (emacs-lisp-mode . rainbow-delimiters-mode)
  (web-mode . rainbow-delimiters-mode)
  (html-mode . rainbow-delimiters-mode)
  (html-ts-mode . rainbow-delimiters-mode)
  (css-mode . rainbow-delimiters-mode)
  (css-ts-mode . rainbow-delimiters-mode)
  (js-mode . rainbow-delimiters-mode)
  (js-ts-mode . rainbow-delimiters-mode)
  (typescript-mode . rainbow-delimiters-mode)
  (typescript-ts-mode . rainbow-delimiters-mode)
  )

;;更改内容显示宽度
(use-package visual-fill-column
  :init
  (setq visual-fill-column-width 140 
		visual-fill-column-center-text t)
  (global-visual-fill-column-mode 1)
  )

;; (use-package modus-themes
;;   :init
;;   ;; Add all your customizations prior to loading the themes
;;   (setq modus-themes-italic-constructs t
;;         modus-themes-bold-constructs t
;;         modus-themes-mode-line '(accented borderless (padding . 10) (height . 0.9))
;;         modus-themes-hl-line '(intense)
;;         modus-themes-paren-match '(bold intense)
;; 		modus-themes-region '(bg-only intense accented)
;; 		modus-themes-syntax '(alt-syntax yellow-comments green-strings)

;;         modus-themes-org-blocks 'gray-background ; {nil,'gray-background,'tinted-background}

;;         modus-themes-headings ; this is an alist: read the manual or its doc string
;;         '((1 . (rainbow variable-pitch 1.3))
;;           (2 . (rainbow  1.2))
;;           (3 . (rainbow  1.1))
;;           (t . (semibold))))
;;   ;; Load the theme files before enabling a theme
;;   (modus-themes-load-themes)
;;   :bind ("<f5>" . modus-themes-toggle))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))

(use-package nyan-mode
  :init
  (nyan-mode 1))

(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
		doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  ;; (doom-themes-neotree-config)
  ;; or for treemacs users
  ;; (setq doom-themes-treemacs-theme "doom-colors") ; use "doom-colors" for less minimal icon theme
  ;; (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)
  )

(when (version< emacs-version "29")
  (use-package leuven-theme)
  )

;;-------------------------custom-----------------------------------
(defun yzs/emacs-ui-config-theme ()
  "主题配置"
  (load-theme 'doom-solarized-light t)
  (custom-set-faces
   ;; '(org-block ((t (:background "gray9"))))
   ;; '(line-number-current-line ((t (:foreground "gold"))))
   ;; `(line-number ((t (:background ,(face-background 'default)))))
   )
  )

;;-------------------------hook-----------------------------------

;; select theme
(add-hook 'after-init-hook 
		  #'(lambda ()

			  ;; (cond
			  ;;  ((string-equal system-type "gnu/linux")
			  ;; 	(cond
			  ;; 	 ((string-equal window-system "x") (yzs/emacs-ui-config-theme))
			  ;; 	 ((string-equal window-system nil) (yzs/emacs-ui-config-theme))
			  ;; 	 ))

			  ;;  ((string-equal system-type "windows-nt") ))

			  (if (display-graphic-p)
				  (yzs/emacs-ui-config-theme)
				(yzs/emacs-ui-config-theme))
			  ))


(provide 'emacs-ui-config)
