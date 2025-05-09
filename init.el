;;; init.el --- entry of emacs _*_ lexical-binding:t _*_

;;; Commentary:

;;; Code:
;;debug
(setq debug-on-error nil)

;;将存有了el文件的文件夹路径添加到load-path中
(let ((default-directory "~/.emacs.d/"))
  (normal-top-level-add-subdirs-to-load-path))

;;解决使用msys2时gun安装包失败的问题
;;(setq package-check-signature nil)
;;(gnu-elpa-keyring-update)
(setq package-gnupghome-dir nil)

(when (>= emacs-major-version 24)
  (require 'package)
  (setq package-archives
				'(
					;; ("melpa-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
					;; ("org-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
					;; ("gnu-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
					;; ("melpa-cn" . "http://1.15.88.122/melpa/")
					;; ("org-cn"   . "http://1.15.88.122/org/")
					;; ("gnu-cn"   . "http://1.15.88.122/gnu/")
					;; ("nongnu" . "http://1.15.88.122/nongnu/")
					("melpa" . "https://melpa.org/packages/")
					("gnu" . "http://elpa.gnu.org/packages/")
					;; ("org" . "http://1.15.88.122/org/")
					))
  (package-initialize)
  )

;;防止反复调用 package-refresh-contents 会影响加载速度
(when (not package-archive-contents)
  (package-refresh-contents))

(setq-local yzs/my-packages '(
															use-package
															))

;; install packages
(defun yzs/install-my-packages (my-packages)
  "安装包.
MY-PACKAGES 是一个需要安装的包的列表."

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

;;; init.el ends here
