;;; emacs-default-config.el --- setup build-in package config -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:
;;open native-comp
(when (and (fboundp 'native-comp-available-p)
		   (native-comp-available-p))
  (progn
	(setq native-comp-async-report-warnings-errors nil)
	(setq comp-deferred-compilation t)
	(add-to-list 'native-comp-eln-load-path (expand-file-name "eln-cache/" user-emacs-directory))
	(setq package-native-compile nil)
	))


;;default is 800 kilobytes. 优化启动速度
(setq gc-cons-threshold (* 20 1000 1000))

(setq inhibit-startup-screen t)
;;(setq initial-major-mode 'text-mode)
(setq initial-scratch-message nil)

;;language envirment
(set-language-environment "utf-8")
(set-default-coding-systems 'utf-8-unix)
;; (set-buffer-file-coding-system 'utf-8-unix)
;; (set-clipboard-coding-system 'utf-8-unix)
;; (set-file-name-coding-system 'utf-8-unix)
;; (set-next-selection-coding-system 'utf-8-unix)
;; (set-selection-coding-system 'utf-8-unix)
;; (set-terminal-coding-system 'utf-8-unix)
;; (setq locale-coding-system 'utf-8-unix)
(when (string-equal system-type "windows-nt")
  (progn
	(prefer-coding-system 'utf-8-auto)
	(modify-coding-system-alist 'process "[cC][mM][dD][pP][rR][oO][xX][yY]" '(gbk . utf-8))
	(modify-coding-system-alist 'process "[rR][gG]" '(utf-8-dos . windows-1251-dos))
	(modify-coding-system-alist 'process "[nN][oO][dD][eE]" '(utf-8-dos . windows-1251-dos))
	))

;;解决python代码解码错误的问题，与treemacs有关
(setenv "PYTHONIOENCODING" "utf-8")

(setq make-backup-files nil)
(setq backup-by-copying t)
(setq create-lockfiles nil)
(setq auto-save-default t)
(setq visible-bell 0)
(setq scroll-step 1 scroll-margin 3)
(setq use-dialog-box nil)
(setq dabbrev-case-replace nil)


(winner-mode 1)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(blink-cursor-mode 0)
(global-hl-line-mode)
(auto-save-visited-mode 1)
;; (recentf-mode 1)
(electric-indent-mode 1)
(electric-pair-mode 1)
(display-time-mode 1)

;; (setq-default display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)
;;用于设置行数三位数以和四位以上,行的位置不匹配的情况
(customize-set-variable 'display-line-numbers-width-start 1)


;;(global-linum-mode 1)
(global-auto-revert-mode 1)
(global-visual-line-mode 1)

;;abbrev-mode
(setq-default abbrev-mode t)
(setq abbrev-file-name (expand-file-name "~/.emacs.d/abbrev_defs"))


(show-paren-mode 1)
(setq show-paren-style 'parenthesis)


(progn
  (require 'dired-x)

  (setq dired-dwim-target t)
  ;; (cond
  ;;  ((string-equal system-type "gnu/linux") (setq dired-listing-switches "-al --time-style long-iso"))
  ;;  ((string-equal system-type "darwin") (setq dired-listing-switches "-alh")))
  (setq dired-recursive-copies 'top)
  (setq dired-recursive-deletes 'top)
  (setq dired-kill-when-opening-new-dired-buffer t)
  (define-key dired-mode-map (kbd "SPC") nil)
  )

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

(setq read-file-name-completion-ignore-case t
	  read-buffer-completion-ignore-case t
	  completion-ignore-case t)

;; whitespace-mode config
(progn
  ;; (setq-default whitespace-style '(face tabs spaces empty newline trailing space-mark tab-mark newline-mark))
  (setq-default whitespace-style '(face empty newline trailing))
  (setq-default whitespace-display-mappings '(
											  ;; (space-mark 32 [183] [46])
											  ;; (newline-mark ?\n [172 ?\n] [36 ?\n])
											  ;; windows
											  ;; (newline-mark ?\r [182] [35])
											  ;; (table-mark ?\t [187 ?\t] [62 ?\t])
											  ))
  (setq-default whitespace-action '(cleanup auto-cleanup))
  (setq-default whitespace-global-modes '(not org-mode))
  ;; (custom-set-faces
  ;;  `(whitespace-newline					((t (:foreground "#aaaaaa"))))
  ;;  `(whitespace-missing-newline-at-eof	((t (:foreground "#aaaaaa"))))
  ;;  `(whitespace-space					((t (:foreground "#aaaaaa"))))
  ;;  `(whitespace-space-after-tab			((t (:foreground "#aaaaaa"))))
  ;;  `(whitespace-space-before-tab		((t (:foreground "#aaaaaa"))))
  ;;  `(whitespace-tab						((t (:foreground "#aaaaaa"))))
  ;;  `(whitespace-trailing				((t (:foreground "#aaaaaa"))))
  ;;  )
  (global-whitespace-mode 1)
  )


;; esc always quits
;; 不知道为什么使用 "ESC" 的方式绑定会导致很多键无法使用
;; 参考:https://emacs.stackexchange.com/questions/14755/how-to-remove-bindings-to-the-esc-prefix-key

(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'keyboard-quit)

(define-key occur-mode-map (kbd "C-c C-p") #'occur-edit-mode)
(global-set-key [remap dabbrev-expand] #'hippie-expand)

(setq-default tab-always-indent t)
;; no mixed tab space
;;(setq-default indent-tabs-mode t)
;; gnu emacs 23.1, 24.4.1 default is t
;; 4 is more popular than 8.
(setq-default tab-width 2)

(setq sentence-end-double-space nil )

;; make typing delete/overwrites selected text
(delete-selection-mode 1)

(setq shift-select-mode nil)


;;代码折叠
;; (add-to-list 'hs-special-modes-alist '(web-mode  "{\\|<[^/>]+?" "}\\|</[^/>]*[^/]>" "<!--" web-mode-forward-sexp nil))
(add-hook 'prog-mode-hook 'hs-minor-mode)


;; convenient
(if (>= emacs-major-version 28)
	(setq use-short-answers t)
  (defalias 'yes-or-no-p 'y-or-n-p))

;;设置treesitter的加载路径和模式
(if (and (eq system-type 'gnu/linux) (treesit-available-p))
	(require 'default-treesitter)
  )

(require 'default-frame-font)
(require 'default-prettify-symbols)

(provide 'emacs-default-config)
;;; emacs-default-config.el ends here
