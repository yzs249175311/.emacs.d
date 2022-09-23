(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/lisp/code/")

;;open debug
(setq debug-on-error t)

(require 'emacs-default-config)
(require 'emacs-custom-config)

;;解决使用msys2时gun安装包失败的问题
;;(setq package-check-signature nil)
;;(gnu-elpa-keyring-update)
(setq package-gnupghome-dir nil)

(when (>= emacs-major-version 24)
  (require 'package)
  (setq package-archives
        '(
          ;;("melpa-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
          ;;("org-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
          ;;("gnu-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
          ("melpa-cn" . "http://elpa.zilongshanren.com/melpa/")
          ("org-cn"   . "http://elpa.zilongshanren.com/org/")
          ("gnu-cn"   . "http://elpa.zilongshanren.com/gnu/")
          ;;("melpa" . "https://melpa.org/packages/")
          ;;("gnu" . "http://elpa.gnu.org/packages/")
          ))
  (package-initialize)
)

;;防止反复调用 package-refresh-contents 会影响加载速度
(when (not package-archive-contents)
  (package-refresh-contents))

(setq my-packages '(
                    use-package
                    pyim
                    pyim-basedict
                    ))

;; install packages
(defun install-my-packages (my-packages)
  (if my-packages
      (let ((my-package (car my-packages)))
        (message "install %s" my-package)
        (unless (package-installed-p my-package)
          (package-install my-package))
        (install-my-packages (cdr my-packages)))))

(install-my-packages my-packages)

;;-----------------------------config-------------------------------------------
;;use-package config
(eval-when-compile
  (require 'use-package)
  (setq use-package-always-ensure t)
  (setq use-package-always-defer t)
  )

(require 'emacs-evil-config)
(require 'emacs-advance-config)
(require 'emacs-code-config)
(require 'emacs-org-config)
(require 'emacs-ui-config)
(require 'emacs-pyim-config)
(require 'emacs-key-binding-config)

;;----------------------------auto-generate-------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("dd33f81b8d9895e727d56ad05ba6c2a90b5c400e80701f788a4542055f1fd838" default))
 '(package-selected-packages
   '(general lsp-ui evil-surround yasnippet-snippets which-key web-mode visual-fill-column vertico use-package typescript-mode treemacs rainbow-delimiters pyim-basedict pyim org-bullets orderless leuven-theme keycast emmet-mode eglot company-web color-theme-sanityinc-tomorrow))
 '(warning-suppress-types '((use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
