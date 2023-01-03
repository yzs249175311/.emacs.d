(use-package flycheck
  :init
  (global-flycheck-mode 1)
  :hook
  (org-mode . (lambda () (flycheck-mode -1))))

;; (use-package company
;;   :hook
;;   (after-init . global-company-mode)

;;   ;; (web-mode . (lambda ()
;;   ;;               (add-to-list 'company-backends 'company-web-html)
;;   ;; 				(add-to-list 'company-backends 'company-yasnippet)
;;   ;; 				))
;;   :bind
;;   (:map company-mode-map
;;         ("C-M-i" . company-complete)
;; 		("C-M-/" . company-dabbrev-code))
;;   (:map company-active-map
;; 		([remap evil-normal-state] . company-abort))
;;   :config
;;   (setq company-minimum-prefix-length 3))

;; (use-package company-web)

(use-package yaml-mode)

(require 'code-web)
(require 'code-lsp)

(provide 'emacs-code-config)
