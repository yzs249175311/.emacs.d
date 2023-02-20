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
(set-language-environment "utf-8")
(set-default-coding-systems 'utf-8-unix)
;; (set-buffer-file-coding-system 'utf-8-unix)
;; (set-clipboard-coding-system 'utf-8-unix)
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
(setq use-dialog-box nil)


(winner-mode 1)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(blink-cursor-mode 0)
(global-hl-line-mode)
(auto-save-visited-mode 1)
(recentf-mode 1)
(electric-indent-mode 1)
(global-display-line-numbers-mode 1)
;;(global-linum-mode 1)
(global-auto-revert-mode 1)
;; (global-visual-line-mode 1)

;;abbrev-mode
(setq-default abbrev-mode t)
(setq abbrev-file-name (expand-file-name "~/.emacs.d/abbrev_defs"))

;; set 
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

;;; esc always quits
;; 不知道为什么使用 "ESC" 的方式绑定会导致很多键无法使用
;; 参考:https://emacs.stackexchange.com/questions/14755/how-to-remove-bindings-to-the-esc-prefix-key
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'keyboard-quit)

(set-default 'tab-always-indent t)
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
;; (add-to-list 'hs-special-modes-alist '(web-mode  "{\\|<[^/>]+?" "}\\|</[^/>]*[^/]>" "<!--" web-mode-forward-sexp nil))
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'css-mode 'hs-minor-mode)
(add-hook 'js-mode 'hs-minor-mode)
(add-hook 'scss-mode 'hs-minor-mode)
(add-hook 'web-mode 'hs-minor-mode)


;; convenient
(if (>= emacs-major-version 28)
	(setq use-short-answers t)
  (defalias 'yes-or-no-p 'y-or-n-p))

(require 'default-frame-font)
(require 'default-prettify-symbols)

(provide 'emacs-default-config)
