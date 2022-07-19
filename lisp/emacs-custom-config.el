(defun open-with-browser () 
  "使用浏览器打开当前文件"
  (interactive)
  (if buffer-file-name
      (cond 
       ((string-equal system-type "windows-nt") 
        (shell-command-to-string (format "MicrosoftEdge.exe %s" buffer-file-name)))))
  )

(global-set-key (kbd "C-c o b") 'open-with-browser)
(provide 'emacs-custom-config)
