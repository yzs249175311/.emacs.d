(use-package leuven-theme)
(use-package color-theme-sanityinc-tomorrow)  
(add-hook 'after-init-hook 
          #'(lambda ()
            (cond
             ((string-equal system-type "gnu/linux") (load-theme 'tsdh-dark t))
             ((string-equal system-type "windows-nt") (load-theme 'sanityinc-tomorrow-eighties t)))
            ))
;;(load-theme 'leuven-dark t)           ;
(provide 'emacs-ui-config)
