;;; code-web.el --- web config -*- lexical-binding:t -*-

;;; Commentary:

;;; Code:
(use-package emmet-mode
  :bind (:map emmet-mode-keymap
              ("M-." . emmet-expand-line))
  :hook
  (web-mode . emmet-mode)
  (scss-mode . emmet-mode)
  :custom
  (emmet-indent-after-insert nil)
  )

(use-package web-mode
  :mode ("\\.html?\\'" "\\.vue\\'" "\\.jsx?$" "\\.tsx?$")
  :config
  (add-to-list 'hs-special-modes-alist '(web-mode  "{\\|<[^/>]+?" "}\\|</[^/>]*[^/]>" "<!--" web-mode-forward-sexp nil))
  (setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
	(evil-define-key 'normal web-mode-map (kbd "SPC m r") 'web-mode-element-rename)
	(evil-define-key 'normal web-mode-map (kbd "SPC m p") 'web-mode-element-previous)
	(evil-define-key 'normal web-mode-map (kbd "SPC m n") 'web-mode-element-next)
	(evil-define-key 'normal web-mode-map (kbd "SPC m k") 'web-mode-attribute-kill)
	(evil-define-key 'normal web-mode-map (kbd "SPC m u") 'web-mode-element-parent)
  :bind
  (:map web-mode-map
		("M-;" . nil)))

;; (use-package auto-rename-tag
;;   :hook
;;   (web-mode . auto-rename-tag-mode)
;;   )


(provide 'code-web)

;;; code-web.el ends here
