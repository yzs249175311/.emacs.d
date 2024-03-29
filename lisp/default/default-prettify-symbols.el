;;; default-prettify-symbols.el --- prettify config -*- lexical-binding:t -*-

;;; Commentary:

;;; Code:
(setq-default prettify-symbols-alist '(("lambda" . "λ")
									   ("->" . "→")
									   ("->>" . "↠")
									   ("=>" . "⇒")
									   ;; ("map" . "↦")
									   ;; ("/=" . "≠")
									   ("!=" . "≠")
									   ;; ("==" . "≡")
									   ("<=" . "≤")
									   (">=" . "≥")
									   ("=<<" . "=≪")
									   (">>=" . "≫=")
									   ("<=<" . "↢")
									   (">=>" . "↣")
									   ;; ("!" . "￢")
									   ;; ("function" . "ƒ")
									   ;; ("&&" . "∧")
									   ;; ("||" . "∨")
									   ))

(defvar-local yzs/symbols-org-mode '(
									 ;; ("TODO" . "")
									 ;; ("WAIT" . "")
									 ;; ("DONE" . "")
									 ("[ ]" . "")
									 ("[X]" . "")
									 ("[-]" . "")
									 ("#+BEGIN_SRC" . "")
									 ("#+END_SRC" . "―")
									 ("#+begin_src" . "")
									 ("#+end_src" . "―")
									 ("#+begin_example" . "")
									 ("#+end_example" . "―")
									 ("#+BEGIN_EXAMPLE" . "")
									 ("#+END_EXAMPLE" . "―")
									 ))

(defmacro yzs/add-prettify-symbols-to-mode (mode &rest symbols-list)
  "Add Prettify Symbols To Mode "
  `(add-hook (intern (concat (symbol-name ,mode) "-hook"))
			 #'(lambda ()
				 (setq prettify-symbols-alist (default-value 'prettify-symbols-alist))
				 (when (listp ',symbols-list)
				   (setq prettify-symbols-alist
						 (append prettify-symbols-alist ,@symbols-list)))
				 (prettify-symbols-mode 1))))

(when (display-graphic-p)
  (yzs/add-prettify-symbols-to-mode 'org-mode yzs/symbols-org-mode)
  (yzs/add-prettify-symbols-to-mode 'emacs-lisp-mode nil)
  (yzs/add-prettify-symbols-to-mode 'prog-mode)
  ;; (yzs/add-prettify-symbols-to-mode 'corfu-mode nil)
  )

(provide 'default-prettify-symbols)

;;; default-prettify-symbols.el ends here
