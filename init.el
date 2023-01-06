;;debug
(setq debug-on-error nil)

(mapc (lambda (dir) (add-to-list 'load-path dir))
	  '(
		"~/.emacs.d/lisp/"
		"~/.emacs.d/lisp/code"
		"~/.emacs.d/lisp/default"
		))

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

(setq yzs/my-packages '(
						use-package
						pyim
						pyim-basedict
						))

;; install packages
(defun yzs/install-my-packages (my-packages)
  (if my-packages
	  (let ((my-package (car my-packages)))
		(message "install %s" my-package)
		(unless (package-installed-p my-package)
		  (package-install my-package))
		(yzs/install-my-packages (cdr my-packages)))))

(yzs/install-my-packages yzs/my-packages)

;;-----------------------------config-------------------------------------------
;;use-package config
(eval-when-compile
  (require 'use-package)
  (setq use-package-always-ensure t)
  (setq use-package-always-defer t)
  )

(require 'emacs-evil-config)
(require 'emacs-better-config)
(require 'emacs-code-config)
(require 'emacs-org-config)
(require 'emacs-ui-config)
(require 'emacs-pyim-config)
(require 'emacs-key-binding-config)

;;----------------------------auto-generate-------------------------------------------
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)
