(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/lisp/code/")

;;open debug
(setq debug-on-error nil)

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

(use-package evil
  :defer nil
  :init 
  (progn
    (setq evil-want-keybinding nil)
    (setq evil-want-C-i-jump nil)
    (setq evil-undo-system 'undo-redo)
    (setq evil-want-C-u-scroll t))
  (cond 
   ((string-equal system-type "windows-nt") 
    (add-hook 'evil-normal-state-entry-hook (lambda () (w32-set-ime-open-status nil)))))
  :config
  (evil-mode)

  (setq evil-motion-state-modes 
        (append '(
                  treemacs-mode 
                  magit-status-mode
                  helpful-mode
                  ) 
                evil-motion-state-modes))
  )

;; (use-package evil-collection
;;   :defer nil
;;   :after evil
;;   :config
;;   (evil-collection-init)
;;   :custom 
;;   (evil-collection-setup-minibuffer t)
;; )

(require 'emacs-advance-config)
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
   '("dd33f81b8d9895e727d56ad05ba6c2a90b5c400e80701f788a4542055f1fd838" default))
 '(org-agenda-files
   '("d:/NutStore/note/GTD/life.org" "d:/NutStore/note/GTD/read.org"))
 '(package-selected-packages
   '(modus-themes yasnippet-snippets which-key web-mode visual-fill-column vertico use-package typescript-mode treemacs rainbow-delimiters pyim-basedict pyim projectile org-bullets orderless marginalia magit lsp-mode leuven-theme keycast helpful evil-collection emmet-mode embark-consult eglot company-web color-theme-sanityinc-tomorrow auto-rename-tag))
 '(warning-suppress-types '((use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
