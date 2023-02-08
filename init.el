;;debug
(setq debug-on-error nil)

(mapc (lambda (dir) (add-to-list 'load-path dir))
	  '(
		"~/.emacs.d/lisp/"
		"~/.emacs.d/lisp/code"
		"~/.emacs.d/lisp/default"
		))


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
		  ("melpa-cn" . "http://1.15.88.122/melpa/")
		  ;; ("org-cn"   . "http://1.15.88.122/org/")
		  ("gnu-cn"   . "http://1.15.88.122/gnu/")
		  ("nongnu" . "http://1.15.88.122/nongnu/")
		  ;;("melpa" . "https://melpa.org/packages/")
		  ;;("gnu" . "http://elpa.gnu.org/packages/")
		  ;; ("org" . "http://1.15.88.122/org/")
		  ))
  (package-initialize)
  )

;;防止反复调用 package-refresh-contents 会影响加载速度
(when (not package-archive-contents)
  (package-refresh-contents))

(setq yzs/my-packages '(
						use-package
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

  ;; use straight.el
  (unless (featurep 'straight)
	(progn
	  (defvar bootstrap-version)
	  (let ((bootstrap-file
			 (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
			(bootstrap-version 6))
		(unless (file-exists-p bootstrap-file)
		  (with-current-buffer
			  (url-retrieve-synchronously
			   "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
			   'silent 'inhibit-cookies)
			(goto-char (point-max))
			(eval-print-last-sexp)))
		(load bootstrap-file nil 'nomessage)))))

(require 'emacs-ui-config)
(require 'emacs-default-config)
(require 'emacs-custom-config)

(require 'emacs-evil-config)
(require 'emacs-better-config)
(require 'emacs-code-config)
(require 'emacs-org-config)
(require 'emacs-pyim-config)
(require 'emacs-key-binding-config)

;;----------------------------auto-generate-------------------------------------------
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)
