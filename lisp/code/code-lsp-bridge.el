(use-package lsp-bridge
  :ensure nil
  :after yasnippet
  :load-path "~/.emacs.d/straight/repos/lsp-bridge/acm"
  :load-path "~/.emacs.d/straight/repos/lsp-bridge"
  :straight '(lsp-bridge :type git :host github :repo "manateelazycat/lsp-bridge")
  :init
  (global-lsp-bridge-mode)
  :bind
  (:map acm-mode-map
		("RET" . nil))
  :config
  ;; (defun lsp-bridge-not-in-string ()
  ;; 	(interactive)
  ;; 	"Hide completion if cursor in string area."
  ;; 	(or
  ;; 	 (memq major-mode '(typescript-mode javascript-mode js-mode js2-mode web-mode))
  ;; 	 ;; Allow sdcv completion in string area
  ;; 	 acm-enable-search-sdcv-words
  ;; 	 ;; Allow volar popup completion menu in string.
  ;; 	 (and (boundp 'acm-backend-lsp-filepath)
  ;; 		  acm-backend-lsp-filepath
  ;; 		  (string-suffix-p ".vue" acm-backend-lsp-filepath))
  ;; 	 ;; Other language not allowed popup completion in string, it's annoy
  ;; 	 (not (acm-in-string-p))
  ;; 	 ;; Allow popup completion menu for string interpolation
  ;; 	 (lsp-bridge-string-interpolation-p lsp-bridge-string-interpolation-open-chars-alist)
  ;; 	 ;; Allow file path completion in string area
  ;; 	 (ignore-errors
  ;; 	   (and (thing-at-point 'filename)
  ;; 			(file-exists-p (file-name-directory (thing-at-point 'filename))))))
  ;; 	)
  (add-to-list 'lsp-bridge-single-lang-server-mode-list '(json-mode . "vscode-json-language-server"))

  (when (assoc 'typescript-mode lsp-bridge-string-interpolation-open-chars-alist)
	(setf (alist-get 'typescript-mode lsp-bridge-string-interpolation-open-chars-alist) "{\\|\"\\|\'")
	)
  (when (assoc 'js-mode lsp-bridge-string-interpolation-open-chars-alist)
	(setf (alist-get 'js-mode lsp-bridge-string-interpolation-open-chars-alist) "{\\|\"\\|\'")
	)
  :custom
  (lsp-bridge-enable-hover-diagnostic t)
  (acm-enable-doc nil)
  (acm-enable-tabnine t)
  :bind
  (:map lsp-bridge-mode-map
		("M-/" . 'lsp-bridge-popup-complete-menu))
  )

(provide 'code-lsp-bridge)
