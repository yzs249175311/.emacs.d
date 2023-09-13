;;; code-web.el --- web config -*- lexical-binding:t -*-

;;; Commentary:

;;; Code:
(use-package emmet-mode
  :bind (:map emmet-mode-keymap
              ("M-." . emmet-expand-line))
  :hook
  (web-mode . emmet-mode)
  )

(use-package web-mode
  :mode ("\\.html?\\'" "\\.vue\\'" "\\.jsx?$")
  :config
  (add-to-list 'hs-special-modes-alist '(web-mode  "{\\|<[^/>]+?" "}\\|</[^/>]*[^/]>" "<!--" web-mode-forward-sexp nil))
  (setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
  :bind
  (:map web-mode-map
		("M-;" . nil))
  :custom
  (web-mode-code-indent-offset 2)
  (web-mode-markup-indent-offset 2)
  )

;; (use-package auto-rename-tag
;;   :hook
;;   (web-mode . auto-rename-tag-mode)
;;   )


(provide 'code-web)

;;; code-web.el ends here
