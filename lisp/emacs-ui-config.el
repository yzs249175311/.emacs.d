(use-package leuven-theme)
  
(add-hook 'after-init-hook 
          #'(lambda ()
            (cond
             ((string-equal system-type "gnu/linux") (load-theme 'tsdh-dark t))
             ((string-equal system-type "windows-nt") (load-theme 'leuven-dark t)))
            ))
;;(load-theme 'leuven-dark t)           ;
(provide 'emacs-ui-config)
