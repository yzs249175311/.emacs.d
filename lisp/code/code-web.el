;;; code-web.el --- web config -*- lexical-binding:t -*-

;;; Commentary:

;;; Code:
(use-package emmet-mode
  :bind (:map emmet-mode-keymap
              ("M-." . emmet-expand-line))
	:config
	(add-to-list 'emmet-jsx-major-modes 'web-mode)
  :hook
  (web-mode . emmet-mode)
  (scss-mode . emmet-mode)
  (css-mode . emmet-mode)
  (css-ts-mode . emmet-mode)
  (tsx-ts-mode . emmet-mode)
  (js-ts-mode . emmet-mode)
  ;; (emmet-mode . emmet-preview-mode)
  :custom
  (emmet-indent-after-insert t)
  )

(use-package web-mode
  :mode ("\\.html?\\'" "\\.vue\\'" "\\.jsx\\'" "\\.tsx\\'")
  :config
  (add-to-list 'hs-special-modes-alist '(web-mode  "{\\|<[^/>]+?" "}\\|</[^/>]*[^/]>" "<!--" web-mode-forward-sexp nil))
  ;; (setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
  :bind
  (:map web-mode-map
		("M-;" . nil)))

;; (use-package auto-rename-tag
;;   :hook
;;   (web-mode . auto-rename-tag-mode)
;;   )


(provide 'code-web)

;;; code-web.el ends here
