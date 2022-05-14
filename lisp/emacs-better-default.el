(require 'package)

(setq inhibit-startup-screen t)

;;set font size
(set-face-attribute 'default nil :height 130)

;;设置窗口大小
(cond 
 ((string-equal system-type "windows-nt") (progn 
                                            (set-frame-position (selected-frame) 0 0)
                                            (set-frame-width  (selected-frame) 140)
                                            (set-frame-height (selected-frame) 45))))


(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8-unix)

(setq make-backup-files nil)
(setq backup-by-copying t)
(setq create-lockfiles nil)
(setq auto-save-default nil)
(setq visible-bell 0)

(global-auto-revert-mode 1)

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(global-linum-mode 1)
(blink-cursor-mode 0)
(setq use-dialog-box nil)

(recentf-mode 1)

(progn
  (require 'dired-x)

  (setq dired-dwim-target t)
  ;; (cond
  ;;  ((string-equal system-type "gnu/linux") (setq dired-listing-switches "-al --time-style long-iso"))
  ;;  ((string-equal system-type "darwin") (setq dired-listing-switches "-alh")))
  (setq dired-recursive-copies 'top)
  (setq dired-recursive-deletes 'top))

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

;;(progn
;;  ;; minibuffer enhanced completion
;;  (require 'icomplete)
;;  (icomplete-mode 1)
;;  ;; show choices vertically
;;  (setq icomplete-separator "\n")
;;  (setq icomplete-hide-common-prefix nil)
;;  (setq icomplete-in-buffer t)
;;  (define-key icomplete-minibuffer-map (kbd "C-n") 'icomplete-forward-completions)
;;  (define-key icomplete-minibuffer-map (kbd "C-p") 'icomplete-backward-completions))


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

;;(progn
;;  ;; make buffer switch command do suggestions, also for find-file command
;;  (require 'ido)
;;  (ido-mode 1)
;;
;;  ;; show choices vertically
;;  (if (version< emacs-version "25")
;;      (setq ido-separator "\n")
;;    (setf (nth 2 ido-decorations) "\n"))
;;
;;  ;; show any name that has the chars you typed
;;  (setq ido-enable-flex-matching t)
;;  ;; use current pane for newly opened file
;;  (setq ido-default-file-method 'selected-window)
;;  ;; use current pane for newly switched buffer
;;  (setq ido-default-buffer-method 'selected-window)
;;  ;; stop ido from suggesting when naming new file
;;  (when (boundp 'ido-minor-mode-map-entry)
;;    (define-key (cdr ido-minor-mode-map-entry) [remap write-file] nil))
;;  (define-key ido-file-completion-map (kbd "C-n") 'ido-next-match)
;;  (define-key ido-file-completion-map (kbd "C-p") 'ido-prev-match))

;; set highlighting brackets
(show-paren-mode 1)
(setq show-paren-style 'parenthesis)

(electric-indent-mode 0)

(set-default 'tab-always-indent 'complete)
;; no mixed tab space
(setq-default indent-tabs-mode nil)
                                        ; gnu emacs 23.1, 24.4.1 default is t

;; 4 is more popular than 8.
(setq-default tab-width 4)

(setq sentence-end-double-space nil )

;; make typing delete/overwrites selected text
(delete-selection-mode 1)

(setq shift-select-mode nil)

(electric-pair-mode 1)

;; convenient
(defalias 'yes-or-no-p 'y-or-n-p)

;;set global key
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-f") 'find-function-on-key)

(provide 'emacs-better-default)
