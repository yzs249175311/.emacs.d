;;彩虹括号
(use-package rainbow-delimiters
  :hook
  (web-mode . rainbow-delimiters-mode)
  (html-mode . rainbow-delimiters-mode)
  (css-mode . rainbow-delimiters-mode)
  (js-mode . rainbow-delimiters-mode)
  (emacs-lisp-mode . rainbow-delimiters-mode)
  )

;;更改内容显示宽度
(use-package visual-fill-column
  :init (setq visual-fill-column-width 120 
              visual-fill-column-center-text t)
  :hook
  (org-mode . visual-fill-column-mode))

(use-package modus-themes
  :init
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs t
        modus-themes-mode-line '(accented borderless (padding . 10) (height . 0.9))
        modus-themes-hl-line '(intense)
        modus-themes-paren-match '(bold intense)
		modus-themes-region '(bg-only intense accented)
		modus-themes-syntax '(alt-syntax yellow-comments green-strings)

        modus-themes-org-blocks 'gray-background ; {nil,'gray-background,'tinted-background}

        modus-themes-headings ; this is an alist: read the manual or its doc string
        '((1 . (overline background variable-pitch 1.3))
          (2 . (rainbow overline 1.2))
          (3 . (rainbow overline 1.1))
          (t . (semibold))))
  ;; Load the theme files before enabling a theme
  (modus-themes-load-themes)
  :bind ("<f5>" . modus-themes-toggle))

;;-------------------------hook-----------------------------------
(add-hook 'after-init-hook 
          #'(lambda ()
            (cond
             ;;((string-equal system-type "gnu/linux") (load-theme 'tsdh-dark t))
             ((string-equal system-type "gnu/linux") (modus-themes-load-vivendi))
             ((string-equal system-type "windows-nt") (modus-themes-load-vivendi))
)))
(provide 'emacs-ui-config)
