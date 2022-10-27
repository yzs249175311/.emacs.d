;;open native-comp
(when (and (fboundp 'native-comp-available-p)
           (native-comp-available-p))
  (progn
    (setq native-comp-async-report-warnings-errors nil)
    (setq comp-deferred-compilation t)
    (add-to-list 'native-comp-eln-load-path (expand-file-name "eln-cache/" user-emacs-directory))
    (setq package-native-compile t)
    ))


;;default is 800 kilobytes. 优化启动速度 
(setq gc-cons-threshold (* 20 1000 1000))

(setq inhibit-startup-screen t)
;;(setq initial-major-mode 'text-mode)
(setq initial-scratch-message nil)

;;language envirment
(set-language-environment 'utf-8)
;; (set-default-coding-systems 'utf-8-unix)
;; (set-buffer-file-coding-system 'utf-8-unix)
;;(set-clipboard-coding-system 'utf-8-unix)
;; (set-file-name-coding-system 'utf-8-unix)
;; (set-next-selection-coding-system 'utf-8-unix)
;; (set-selection-coding-system 'utf-8-unix)
;; (set-terminal-coding-system 'utf-8-unix)
;; (setq locale-coding-system 'utf-8-unix)
(if (string-equal system-type "windows-nt")
	(progn
	  (prefer-coding-system 'utf-8-auto)
	  )
  (progn
	(prefer-coding-system 'utf-8-auto)
	))

;;解决python代码解码错误的问题，与treemacs有关
(setenv "PYTHONIOENCODING" "utf-8")

(setq make-backup-files nil)
(setq backup-by-copying t)
(setq create-lockfiles nil)
(setq auto-save-default nil)
(setq visible-bell 0)
(setq scroll-step 1 scroll-margin 3)

(global-display-line-numbers-mode 1)
;;(global-linum-mode 1)
(global-auto-revert-mode 1)


(winner-mode 1)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(blink-cursor-mode 0)
(global-hl-line-mode)
(auto-save-visited-mode 1)
(recentf-mode 1)
(setq use-dialog-box nil)

(progn
  (require 'dired-x)

  (setq dired-dwim-target t)
  ;; (cond
  ;;  ((string-equal system-type "gnu/linux") (setq dired-listing-switches "-al --time-style long-iso"))
  ;;  ((string-equal system-type "darwin") (setq dired-listing-switches "-alh")))
  (setq dired-recursive-copies 'top)
  (setq dired-recursive-deletes 'top)
  (setq dired-kill-when-opening-new-dired-buffer t))

(progn
  ;; no need to warn
  (put 'narrow-to-region 'disabled nil)
  (put 'narrow-to-page 'disabled nil)
  (put 'upcase-region 'disabled nil)
  (put 'downcase-region 'disabled nil)
  (put 'erase-buffer 'disabled nil)
  (put 'scroll-left 'disabled nil)
  (put 'dired-find-alternate-file 'disabled nil)
  )

(progn
  ;; minibuffer setup
  (setq enable-recursive-minibuffers t)
  (savehist-mode 1)
  ;; big minibuffer height, for ido to show choices vertically
  (setq max-mini-window-height 0.5)
  ;; minibuffer, stop cursor going into prompt
  (customize-set-variable
   'minibuffer-prompt-properties
   (quote (read-only t cursor-intangible t face minibuffer-prompt))))

;; set 
(show-paren-mode 1)
(setq show-paren-style 'parenthesis)

(electric-indent-mode 1)

;;(set-default 'tab-always-indent t)
;; no mixed tab space
;;(setq-default indent-tabs-mode t)
					; gnu emacs 23.1, 24.4.1 default is t

;; 4 is more popular than 8.
(setq-default tab-width 4)

(setq sentence-end-double-space nil )

;; make typing delete/overwrites selected text
(delete-selection-mode 1)

(setq shift-select-mode nil)

(electric-pair-mode 1)

;;代码折叠
(add-to-list 'hs-special-modes-alist '(web-mode  "{\\|<[^/>]+?" "}\\|</[^/>]*[^/]>" "<!--" web-mode-forward-sexp nil))



;;设置窗口
(cond 
 ((string-equal system-type "windows-nt")
  (mapc '(lambda (elm) (push elm default-frame-alist))
	'((height . 45)
	  (width . 160)
	  (left . 25)
	  (top . 25))))
 ((string-equal system-type "gnu/linux")
  (mapc '(lambda (elm) (push elm default-frame-alist))
	'((height . 45)
	  (width . 200)
	  (left . 25)
	  (top . 25)))))

(defun yzs/set-font-faces () 
  ;;set default font
  (set-frame-font
   (cond
    ((string-equal system-type "windows-nt")
     (cond
      ((member "更纱黑体 Mono SC Nerd Bold" (font-family-list)) "更纱黑体 Mono SC Nerd Bold")
      ((member "JetBrains Mono NL" (font-family-list)) "JetBrains Mono NL")
      ((member "Consolas" (font-family-list)) "JetBrains Mono NL")))

    ((string-equal system-type "darwin")
     (cond
      ((member "Menlo"  (font-family-list)) "Menlo-16")))

    ((string-equal system-type "gnu/linux")
     (cond
	  ((font-info "等距更紗黑體 CL Nerd Font") "等距更紗黑體 CL Nerd Font")
	  ((member "JetBrainsMono Nerd Font Mono" (font-family-list)) "JetBrainsMono Nerd Font Mono")
	  ((member "Sarasa Mono J" (font-family-list)) "Sarasa Mono J")
	  ((member "DejaVu Sans Mono"  (font-family-list)) "DejaVu Sans Mono")))
	(t nil))
   t t)

  ;; set font for chinese characters
  (set-fontset-font
   t
   'han
   ;;'han
   (cond
	((string-equal system-type "windows-nt")
	 (cond
	  ((member "Microsoft YaHei" (font-family-list)) "Microsoft YaHei")
	  ((member "Microsoft JhengHei" (font-family-list)) "Microsoft JhengHei")
	  ((member "SimHei" (font-family-list)) "SimHei")))
	((string-equal system-type "darwin")
	 (cond
	  ((member "Hei" (font-family-list)) "Hei")
	  ((member "Heiti SC" (font-family-list)) "Heiti SC")
	  ((member "Heiti TC" (font-family-list)) "Heiti TC")))
	((string-equal system-type "gnu/linux")
	 (cond
	  ((member "WenQuanYi Micro Hei" (font-family-list)) "WenQuanYi Micro Hei")
	  ))))

  ;;set font size
  (set-face-attribute 'default nil :height 120)
  ;; (cond 
  ;;  ((string-equal system-type "windows-nt") (progn 
  ;;                                             (set-frame-position (selected-frame) 0 0)
  ;;                                             (set-frame-width  (selected-frame) 140)
  ;;                                             (set-frame-height (selected-frame) 40)))
  ;;  ((string-equal system-type "gnu/linux") (progn 
  ;; 											  (set-frame-position (selected-frame) 100 100)
  ;; 											  (set-frame-width  (selected-frame) 200)
  ;; 											  (set-frame-height (selected-frame) 40)
  ;; 											  (global-text-scale-adjust 10)))
  ;; )

  )

;; convenient
(if (>= emacs-major-version 28)
	(setq use-short-answers t)
  (defalias 'yes-or-no-p 'y-or-n-p))


;; binding
;; set global key
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-f") 'find-function-on-key)

;; hook
(if (daemonp)
	(add-hook 'after-make-frame-functions
			  (lambda (frame)
				(with-selected-frame frame
				  (yzs/set-font-faces))))
  (add-hook 'modus-themes-after-load-theme-hook 'yzs/set-font-faces)
  )

(require 'default-prettify-symbols)

(provide 'emacs-default-config)
