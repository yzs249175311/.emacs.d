;;彩虹括号
(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode)
  )

;;更改内容显示宽度
(use-package olivetti
  :config
  (remove-hook 'olivetti-mode-on-hook 'visual-line-mode)
  :hook
  (prog-mode . olivetti-mode)
  (outline-mode . olivetti-mode)
  (find-file . olivetti-mode)
  :custom
  (olivetti-body-width 130)
  )

;; (use-package modus-themes
;;   :init
;;   (setq modus-themes-italic-constructs t
;; 		modus-themes-bold-constructs t
;; 		modus-themes-mixed-fonts nil
;; 		modus-themes-variable-pitch-ui nil
;; 		modus-themes-custom-auto-reload t
;; 		modus-themes-disable-other-themes t

;; 		;; Options for `modus-themes-prompts' are either nil (the
;; 		;; default), or a list of properties that may include any of those
;; 		;; symbols: `italic', `WEIGHT'
;; 		modus-themes-prompts '(extrabold italic)

;; 		;; The `modus-themes-completions' is an alist that reads two
;; 		;; keys: `matches', `selection'.  Each accepts a nil value (or
;; 		;; empty list) or a list of properties that can include any of
;; 		;; the following (for WEIGHT read further below):
;; 		;;
;; 		;; `matches'   :: `underline', `italic', `WEIGHT'
;; 		;; selection' :: `underline', `italic', `WEIGHT'

;; 		modus-themes-completions
;; 		'((matches . (extrabold))
;; 		  (selection . (semibold text-also)))

;; 		modus-themes-org-blocks 'gray-background ; {nil,'gray-background,'tinted-background}

;; 		;; The `modus-themes-headings' is an alist: read the manual's
;; 		;; node about it or its doc string.  Basically, it supports
;; 		;; per-level configurations for the optional use of
;; 		;; `variable-pitch' typography, a height value as a multiple of
;; 		;; the base font size (e.g. 1.5), and a `WEIGHT'.
;; 		modus-themes-headings
;; 		'((1 . (variable-pitch 1.5))
;; 		  (2 . (1.3))
;; 		  (agenda-date . (1.3))
;; 		  (agenda-structure . (variable-pitch light 1.8))
;; 		  (t . (1.1))))
;;   :config
;;   (setq modus-themes-italic-constructs t
;; 		modus-themes-bold-constructs t)

;;   ;; Maybe define some palette overrides, such as by using our presets
;;   (setq modus-themes-common-palette-overrides
;; 		modus-themes-preset-overrides-intense)

;;   ;; Load the theme of your choice.
;;   ;; (load-theme 'modus-operandi)
;;   )

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))

;; (use-package nyan-mode
;;   :init
;;   (nyan-mode 1))

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
  (load-theme 'doom-one t)
  (custom-set-faces
   ;; '(org-block ((t (:background "gray9"))))
   ;; '(line-number-current-line ((t (:foreground "gold"))))
   ;; `(line-number		((t (:background ,(face-background 'default)))))
   ;; `(olivetti-fringe	((t (:background ,(face-background 'default)))))
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
