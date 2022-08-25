;;open my init.el file
(defun yzs/open-init ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun yzs/open-file-in-browser () 
  "使用浏览器打开当前文件"
  (interactive)
  (if buffer-file-name
      (cond 
       ((string-equal system-type "windows-nt") 
        (shell-command-to-string (encode-coding-string (format "MicrosoftEdge.exe %s" buffer-file-name) 'gbk))))))

(defun yzs/open-file-in-live-server (file)
  "创建服务器打开此文件,需要使用npm安装browser-sync"
  (interactive "fchoice-file:")
  (if (not file)
      (setq file buffer-file-name))
  (if file
	  (async-shell-command (encode-coding-string (format "Browser-sync start -s -w %s" file) 'gbk)))
  )

(defun yzs/run-code (file)
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


(defun yzs/open-directory(path) 
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

(defun yzs/display-startup-time ()
  "显示启动时间和垃圾包的数量"
  (interactive)
  (message "Emacs loaded in %s with %d garbage collections"
           (format "%.2f secends" 
                   (float-time 
                    (time-subtract after-init-time before-init-time)))
           gcs-done))

;;key binding
(global-set-key (kbd "C-c c b") 'yzs/open-file-in-browser)
(global-set-key (kbd "C-c c d") 'yzs/open-directory)
(global-set-key (kbd "C-c c c") 'yzs/run-code)
(global-set-key (kbd "C-c c s") 'yzs/open-file-in-live-server)

;;hook
(add-hook 'emacs-startup-hook 'yzs/display-startup-time)

(provide 'emacs-custom-config)
