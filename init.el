(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'yzs-emacs-better-default)

(when (>= emacs-major-version 24)
  (require 'package)
  (setq package-archives
        '(("melpa-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
          ("org-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
          ("gnu-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/"))))

(package-initialize)
(package-refresh-contents)

(defvar my-packages '(
                      evil))

;; install packages
(defun install-my-packages (my-packages)
  (let ((my-package (car my-packages)))
     (message "%s" my-package)
     (unless (package-installed-p my-package)
       (package-install my-package)
     (install-my-packages (cdr my-packages)))))

(install-my-packages my-packages)

;;define my function
(defun yzs/open-init ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(require 'evil)
(evil-mode 1)

(load-theme 'tango-dark t)

(require 'yzs-emacs-org)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("57e3f215bef8784157991c4957965aa31bac935aca011b29d7d8e113a652b693" default))
 '(minibuffer-prompt-properties '(read-only t cursor-intangible t face minibuffer-prompt))
 '(org-agenda-files '("d:/NutStore/note/GTD/read.org"))
 '(package-selected-packages '(slime evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
