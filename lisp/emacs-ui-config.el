;;; emacs-ui-config.el --- custom config -*- lexical-binding:t -*-

;;; Commentary:

;;; Code:

;;彩虹括号
(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode)
  )

(use-package kind-icon
  :after corfu
  :init
  (setq completion-in-region-function
   		(kind-icon-enhance-completion completion-in-region-function))
  :custom
  (kind-icon-default-face 'corfu-default) ; to compute blended backgrounds correctly
  (kind-icon-use-icons . nil)
  (kind-icon-blend-background . nil)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package nerd-icons
  :config
  (unless (string-equal "windows-nt" system-type)
	(setq kind-icon-mapping
		  `(
			(array ,(nerd-icons-codicon "nf-cod-symbol_array") :face font-lock-type-face)
			(boolean ,(nerd-icons-codicon "nf-cod-symbol_boolean") :face font-lock-builtin-face)
			(class ,(nerd-icons-codicon "nf-cod-symbol_class") :face font-lock-type-face)
			(color ,(nerd-icons-codicon "nf-cod-symbol_color") :face success)
			(command ,(nerd-icons-codicon "nf-cod-terminal") :face default)
			(constant ,(nerd-icons-codicon "nf-cod-symbol_constant") :face font-lock-constant-face)
			(constructor ,(nerd-icons-codicon "nf-cod-triangle_right") :face font-lock-function-name-face)
			(enummember ,(nerd-icons-codicon "nf-cod-symbol_enum_member") :face font-lock-builtin-face)
			(enum-member ,(nerd-icons-codicon "nf-cod-symbol_enum_member") :face font-lock-builtin-face)
			(enum ,(nerd-icons-codicon "nf-cod-symbol_enum") :face font-lock-builtin-face)
			(event ,(nerd-icons-codicon "nf-cod-symbol_event") :face font-lock-warning-face)
			(field ,(nerd-icons-codicon "nf-cod-symbol_field") :face font-lock-variable-name-face)
			(file ,(nerd-icons-codicon "nf-cod-symbol_file") :face font-lock-string-face)
			(folder ,(nerd-icons-codicon "nf-cod-folder") :face font-lock-doc-face)
			(interface ,(nerd-icons-codicon "nf-cod-symbol_interface") :face font-lock-type-face)
			(keyword ,(nerd-icons-codicon "nf-cod-symbol_keyword") :face font-lock-keyword-face)
			(macro ,(nerd-icons-codicon "nf-cod-symbol_misc") :face font-lock-keyword-face)
			(magic ,(nerd-icons-codicon "nf-cod-wand") :face font-lock-builtin-face)
			(method ,(nerd-icons-codicon "nf-cod-symbol_method") :face font-lock-function-name-face)
			(function ,(nerd-icons-codicon "nf-cod-symbol_method") :face font-lock-function-name-face)
			(module ,(nerd-icons-codicon "nf-cod-file_submodule") :face font-lock-preprocessor-face)
			(numeric ,(nerd-icons-codicon "nf-cod-symbol_numeric") :face font-lock-builtin-face)
			(operator ,(nerd-icons-codicon "nf-cod-symbol_operator") :face font-lock-comment-delimiter-face)
			(param ,(nerd-icons-codicon "nf-cod-symbol_parameter") :face default)
			(property ,(nerd-icons-codicon "nf-cod-symbol_property") :face font-lock-variable-name-face)
			(reference ,(nerd-icons-codicon "nf-cod-references") :face font-lock-variable-name-face)
			(snippet ,(nerd-icons-codicon "nf-cod-symbol_snippet") :face font-lock-string-face)
			(string ,(nerd-icons-codicon "nf-cod-symbol_string") :face font-lock-string-face)
			(struct ,(nerd-icons-codicon "nf-cod-symbol_structure") :face font-lock-variable-name-face)
			(text ,(nerd-icons-codicon "nf-cod-text_size") :face font-lock-doc-face)
			(typeparameter ,(nerd-icons-codicon "nf-cod-list_unordered") :face font-lock-type-face)
			(type-parameter ,(nerd-icons-codicon "nf-cod-list_unordered") :face font-lock-type-face)
			(unit ,(nerd-icons-codicon "nf-cod-symbol_ruler") :face font-lock-constant-face)
			(value ,(nerd-icons-codicon "nf-cod-symbol_field") :face font-lock-builtin-face)
			(variable ,(nerd-icons-codicon "nf-cod-symbol_variable") :face font-lock-variable-name-face)
			(t ,(nerd-icons-codicon "nf-cod-code") :face font-lock-warning-face)))))

(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package treemacs-nerd-icons
  :autoload treemacs-load-theme
  :init
  (treemacs-load-theme "nerd-icons")
  )

(use-package nerd-icons-completion
  :hook
  (after-init . nerd-icons-completion-mode))

;;更改内容显示宽度
(use-package olivetti
  :config
  (remove-hook 'olivetti-mode-on-hook 'visual-line-mode)
  :hook
  (prog-mode . olivetti-mode)
  (outline-mode . olivetti-mode)
  (find-file . olivetti-mode)
  :custom
  (olivetti-body-width 150)
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
  :custom
  (doom-modeline-buffer-file-name-style 'relative-from-project)
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
  (load-theme 'doom-one t)

  (custom-set-faces
   ;; '(org-block ((t (:background "gray9"))))
   ;; '(line-number-current-line ((t (:foreground "gold"))))
   ;; `(line-number		((t (:background ,(face-background 'default)))))
   ;; `(olivetti-fringe	((t (:background ,(face-background 'default)))))
   `(tab-bar-tab ((t (:overline t))))
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
;;; emacs-ui-config.el ends here
