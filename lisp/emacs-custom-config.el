(defun open-with-browser () 
  "使用浏览器打开当前文件"
  (interactive)
  (if buffer-file-name
      (cond 
       ((string-equal system-type "windows-nt") 
        (shell-command-to-string (encode-coding-string (format "MicrosoftEdge.exe %s" buffer-file-name) 'gbk))))))

(defun run-code (file)
  "运行代码,支持javascript,typescript"
  (interactive "fchoice file:")
  (if (not file)
      (setq file buffer-file-name))
  (message "run code: %s" file)
  (cond 
   ((string-match "\.js$" file) 
    (async-shell-command (encode-coding-string (concat "node " file) 'gbk)))
   ((string-match "\.ts$" file) 
    (async-shell-command (encode-coding-string (concat "ts-node " file) 'gbk)))
   (t (message "Can't run this file"))))

(defun open-directory(path) 
  "打开目标文件夹"
  (interactive "DOpen Directory:")
  (if (not path)
      (setq path default-directory))
  (cond 
   ((string-equal system-type "windows-nt") 
    (shell-command-to-string
     (encode-coding-string 
      (replace-regexp-in-string "/" "\\\\" (concat "explorer.exe " (expand-file-name path)))
      'gbk)))))

(global-set-key (kbd "C-c o b") 'open-with-browser)
(global-set-key (kbd "C-c o d") 'open-directory)
(global-set-key (kbd "C-c c c") 'run-code)

(provide 'emacs-custom-config)
