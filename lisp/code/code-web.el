(use-package emmet-mode
  :bind (:map emmet-mode-keymap
              ("M-." . emmet-expand-line))
  :hook
  (web-mode . emmet-mode)
  (css-mode . emmet-mode)
  )

(use-package web-mode
  :mode ("\\.vue\\'" "\\.html?\\'")
  :config
  (add-to-list 'hs-special-modes-alist '(web-mode  "{\\|<[^/>]+?" "}\\|</[^/>]*[^/]>" "<!--" web-mode-forward-sexp nil))
  :bind
  (:map web-mode-map
		("M-;" . nil))
  )

;; (use-package auto-rename-tag
;;   :hook
;;   (web-mode . auto-rename-tag-mode)
;;   )


(provide 'code-web)
