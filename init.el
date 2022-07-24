(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/lisp/code/")

(when (and (fboundp 'native-comp-available-p)
           (native-comp-available-p))
  (progn
    (setq native-comp-async-report-warnings-errors nil)
    (setq comp-deferred-compilation t)
    (add-to-list 'native-comp-eln-load-path (expand-file-name "eln-cache/" user-emacs-directory))
    (setq package-native-compile t)
    ))

(require 'emacs-better-default)
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
          ;;("non-gun-elpa" . "http://1.15.88.122/nongnu/")
          ;;("melpa" . "https://melpa.org/packages/")
          ;;("gnu" . "http://elpa.gnu.org/packages/")
          )))

(package-initialize)
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

;;-----------------------------custom config-------------------------------------------
;; native-comp
(when (and (fboundp 'native-comp-available-p)
           (native-comp-available-p))
  (progn
    (setq native-comp-async-report-warnings-errors nil)
    (setq comp-deferred-compilation t)
    (add-to-list 'native-comp-eln-load-path (expand-file-name "eln-cache/" user-emacs-directory))
    (setq package-native-compile t)
    ))

;;define my function
(defun yzs/open-init ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;;use-package config
(eval-when-compile
  (require 'use-package)
  (setq use-package-always-ensure t)
  (setq use-package-always-defer t)
  )

(use-package evil
  :init (progn
          (setq evil-want-C-i-jump nil)
          (setq evil-undo-system 'undo-redo)
          (evil-mode)
          (cond 
           ((string-equal system-type "windows-nt") (add-hook 'evil-normal-state-entry-hook (lambda () (w32-set-ime-open-status nil))))))
  :hook
  (org-mode . (lambda () (setq evil-shift-width 2)))
  :bind (:map evil-normal-state-map
              ("C-u" . evil-scroll-up)))

(require 'emacs-basic-config)
(require 'emacs-code-config)
(require 'emacs-org-config)
(require 'emacs-ui-config)
(require 'emacs-pyim-config)

;;----------------------------auto-generate-------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("57e3f215bef8784157991c4957965aa31bac935aca011b29d7d8e113a652b693" default))
 '(minibuffer-prompt-properties '(read-only t cursor-intangible t face minibuffer-prompt))
 '(org-agenda-files '("d:/NutStore/note/GTD/read.org"))
 '(package-selected-packages
   '(pyim-cregexp typescript gnu-elpa-keyring-update pyim-cregexp-utils treemacs spinner eglot embark-consult embark marginalia Buffer-menu evil))
 '(warning-suppress-types '((use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
