;;; emacs-pyim-config.el --- pyim config -*- lexical-binding:t -*-

;;; Commentary:

;;; Code:
(use-package pyim
  :init
  (setq default-input-method "pyim")
  ;; 显示5个候选词。
  (setq pyim-page-length 5)
;; 我使用双
  ;;(pyim-default-scheme 'quanpin)
  (pyim-default-scheme 'pyim-shuangpin)
  (pyim-isearch-mode 1)
  )

(use-package pyim-basedict
  :init
  (pyim-basedict-enable)
  )

;; (use-package pyim-cregexp-utils
;;  :init
;;  (progn
;;    (pyim-basedict-enable)
;;    (pyim-default-scheme 'quanpin)
;;    (pyim-isearch-mode 1))
;;  :config
;;  (setq default-input-method "pyim")
;;  (setq pyim-page-length 5)
;; :bind
;; ("C-x p y a" . pyim-activate)
;; ("C-x p y d" . pyim-deactivate)
;; ("C-M-z " . pyim-toggle-input-ascii)
;; )

;; 如果使用 popup page tooltip, 就需要加载 popup 包。
;; (require 'popup nil t)
;; (setq pyim-page-tooltip 'popup)

;; 如果使用 pyim-dregcache dcache 后端，就需要加载 pyim-dregcache 包。
;; (require 'pyim-dregcache)
;; (setq pyim-dcache-backend 'pyim-dregcache)


;; 金手指设置，可以将光标处的编码，比如：拼音字符串，转换为中文。
;;(global-set-key (kbd "M-j") 'pyim-convert-string-at-point)

;; 按 "C-<return>" 将光标前的 regexp 转换为可以搜索中文的 regexp.
;;(define-key minibuffer-local-map (kbd "C-<return>") 'pyim-cregexp-convert-at-point)


;;  ("C-x p y a" . pyim-activate)
;;  ("C-x p y d" . pyim-deactivate)
;;  ("C-M-z " . pyim-toggle-input-ascii))

(provide 'emacs-pyim-config)

;;; emacs-pyim-config.el ends here
