(defun open-with-browser () 
  "使用浏览器打开当前文件"
  (interactive)
  (if buffer-file-name
      (cond 
       ((string-equal system-type "windows-nt") 
        (shell-command-to-string (format "MicrosoftEdge.exe %s" buffer-file-name)))))
  )

(defun run-code (file)
  (interactive "fchoice file:")
  (if (not file)
      (setq file buffer-file-name))
  (cond 
   ((string-match "\.js$" file) (async-shell-command (concat "node " file)))
   ((string-match "\.ts$" file) (async-shell-command (concat "ts-node " file)))))

(global-set-key (kbd "C-c c o") 'open-with-browser)
(global-set-key (kbd "C-c c c") 'run-code)
(global-set-key (kbd "C-c e n") #'flymake-goto-next-error)
(global-set-key (kbd "C-c e p") #'flymake-goto-prev-error)
(provide 'emacs-custom-config)
