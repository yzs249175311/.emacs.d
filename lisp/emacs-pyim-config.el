(use-package pyim)

(use-package pyim-basedict)

(use-package pyim-cregexp-utils
  :init
  (progn 
    (pyim-basedict-enable)
    (pyim-default-scheme 'quanpin)
    (pyim-isearch-mode 1))
  :config
  (progn
    (setq default-input-method "pyim")
    (setq pyim-page-length 5))
  :bind
  ("C-x p y a" . pyim-activate)
  ("C-x p y d" . pyim-deactivate)
  ("C-M-z " . pyim-toggle-input-ascii))

(provide 'emacs-pyim-config)
