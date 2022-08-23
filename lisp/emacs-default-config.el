(require 'package)

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



(set-language-environment "utf-8")
(set-default-coding-systems 'utf-8-unix)
;;解决python代码解码错误的问题，与treemacs有关
(setenv "PYTHONIOENCODING" "utf-8")
;; (prefer-coding-system 'utf-8)
;; ;;;; 设置编辑环境
;; ;; 设置为中文简体语言环境
;;(set-language-environment 'Chinese-GB)

;; ;; 设置emacs 使用 utf-8
;; (setq locale-coding-system 'utf-8)
;; ;; 设置键盘输入时的字符编码
;; (set-keyboard-coding-system 'utf-8)
;; (set-selection-coding-system 'utf-8)
;; ;; 文件默认保存为 utf-8
;; (set-buffer-file-coding-system 'utf-8)
;; (set-default buffer-file-coding-system 'utf-8)
;; (set-default-coding-systems 'utf-8)

;; ;; 解决粘贴中文出现乱码的问题
;; (set-clipboard-coding-system 'utf-8)
;; ;; 终端中文乱码
;; (set-terminal-coding-system 'utf-8)
;; ;; (modify-coding-system-alist 'process "*" 'utf-8)
;; (setq default-process-coding-system '(utf-8 . utf-8))
;; ;; 解决文件目录的中文名乱码
;; (setq-default pathname-coding-system 'utf-8)
;; (set-file-name-coding-system 'utf-8)

(setq make-backup-files nil)
(setq backup-by-copying t)
(setq create-lockfiles nil)
(setq auto-save-default nil)
(setq visible-bell 0)
(setq scroll-step 1 scroll-margin 3)

;;(global-display-line-numbers-mode 1)
;;(global-linum-mode 1
(global-auto-revert-mode 1)

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(blink-cursor-mode 0)
(global-hl-line-mode)
(auto-save-visited-mode 1)
(setq use-dialog-box nil)

(recentf-mode 1)

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

;; set highlighting brackets
(show-paren-mode 1)
(setq show-paren-style 'parenthesis)

(electric-indent-mode 0)

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

(defun yzs/set-font-faces() 
  ;; set default font
  (set-frame-font
   (cond
    ((string-equal system-type "windows-nt")
     (if (member "Consolas" (font-family-list)) "Consolas" nil ))
    ((string-equal system-type "darwin")
     (if (member "Menlo" (font-family-list)) "Menlo-16" nil ))
    ((string-equal system-type "gnu/linux")
     (if (member "DejaVu Sans Mono" (font-family-list)) "DejaVu Sans Mono" nil ))
    (t nil))
   t t)

  ;; set font for chinese characters
  (set-fontset-font
   t
   '(#x4e00 . #x9fff)
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
      ((member "WenQuanYi Micro Hei" (font-family-list)) "WenQuanYi Micro Hei")))))

  ;;set font size

  (cond 
   ((string-equal system-type "windows-nt") (progn 
                                              (set-frame-position (selected-frame) 0 0)
                                              (set-frame-width  (selected-frame) 140)
                                              (set-frame-height (selected-frame) 40))))

  (set-face-attribute 'default nil :height 140)
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
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; hook
(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (with-selected-frame frame
                  (yzs/set-font-faces))))
  (add-hook 'modus-themes-after-load-theme-hook 'yzs/set-font-faces)
  )

(provide 'emacs-default-config)
