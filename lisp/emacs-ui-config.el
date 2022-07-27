(use-package color-theme-sanityinc-tomorrow)  

;; (use-package all-the-icons
;;   :if (display-graphic-p))

(add-hook 'after-init-hook 
          #'(lambda ()
            (cond
             ((string-equal system-type "gnu/linux") (load-theme 'tsdh-dark t))
             ((string-equal system-type "windows-nt") (load-theme 'sanityinc-tomorrow-eighties t)))
            ))
;;(load-theme 'leuven-dark t)           ;
(provide 'emacs-ui-config)
