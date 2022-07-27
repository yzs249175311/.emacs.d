(use-package color-theme-sanityinc-tomorrow)  

;; (use-package all-the-icons
;;   :if (display-graphic-p))

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

(use-package keycast
  :defer nil
  :config
  (keycast-mode))

;; (use-package doom-modeline
;;   :after keycast
;;   :init
;;   (add-to-list 'global-mode-string '("" keycast-mode-line))
;;   (doom-modeline-mode t)
;;   :custom-face
;;   (mode-line ((t (:height 0.9))))
;;   (mode-line-inactive ((t (:height 0.9))))
;;   )

;;-------------------------hook-----------------------------------
(add-hook 'after-init-hook 
          #'(lambda ()
            (cond
             ((string-equal system-type "gnu/linux") (load-theme 'tsdh-dark t))
             ((string-equal system-type "windows-nt") (load-theme 'sanityinc-tomorrow-eighties t)))
            ))

(provide 'emacs-ui-config)
