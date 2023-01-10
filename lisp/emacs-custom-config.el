;;------------------ init variable -------------------------------;;
(setq use-wsl-p nil)
(setq yzs/which-system-open-command (pcase system-type
									  ('darwin "open")
									  ('cygwin "cygstart")
									  (_ "xdg-open")))

(setq yzs/encode
	  (pcase system-type
	   ('windows-nt 'gbk)
	   (t 'utf-8)))

;;------------------ init config begin-------------------------------;;

(defun yzs/tool/path-wsl-to-windows (str)
  (if use-wsl-p
	  (replace-regexp-in-string "\/mnt\/\\(\\w+\\)" "\\1\:" str)
	str)
  )

;;open my init.el file
(defun yzs/open-init ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; (defun yzs/open-file-in-browser () 
;;   "使用浏览器打开当前文件"
;;   (interactive)
;;   (if buffer-file-name
;; 	  (cond 
;; 	   ((string-equal system-type "windows-nt") 
;; 		(shell-command-to-string (encode-coding-string (format "MicrosoftEdge.exe %s" buffer-file-name) yzs/encode)))
;; 	   ((string-equal system-type "gnu/linux") 
;; 		(shell-command-to-string (encode-coding-string (format "microsoft-edge-stable %s" (yzs/tool/path-wsl-to-windows buffer-file-name)) yzs/encode))))))

(defun yzs/open-file-in-system (file)
  (interactive "fOpen File In System:")
  (message "Open the file in system:%s" file)
  (if (and (eq system-type 'windows-nt)
		   (fboundp 'w32-shell-execute))
	  (shell-command-to-string (encode-coding-string (replace-regexp-in-string "/" "\\\\"
																			   (format "%s" (expand-file-name file))) 'gbk))
	(call-process yzs/which-system-open-command
				  nil 0 nil
				  (expand-file-name file))))

(defun yzs/open-file-in-live-server (dir startPath)
  "创建服务器打开此文件,需要使用npm安装browser-sync"
  (interactive "DChoose a dir for server root:\nfChoose a file for startPath:")
  (message "Start Live Server\nDIR:%s\nstartPath:%s" dir startPath)
  (if (and dir startPath) 
	  (let ((edir (expand-file-name dir)) (estartPath (expand-file-name startPath)))
		(async-shell-command
		 (encode-coding-string
		  (format "browser-sync start -s \"%s\" -w \"%s\" --startPath \"%s\""
				  edir
				  estartPath
				  (substring estartPath (length edir))) yzs/encode)))))

(defun yzs/run-code (file)
  "运行代码,支持javascript,typescript"
  (interactive "fChoice file:")
  (unless (file-exists-p file)
	  (setq-local file buffer-file-name))
  (message "run code: %s" file)
  (cond 
   ((string-match "\.js$" file) 
	(async-shell-command (encode-coding-string (concat "node " file) yzs/encode)))
   ((string-match "\.ts$" file) 
	(async-shell-command (encode-coding-string (concat "ts-node " file) yzs/encode)))
   (t (message "Can't run this file"))))

(defun yzs/run-code-deamon (file)
  "运行代码,支持javascript,typescript"
  (interactive "fChoice file:")
  (unless (file-exists-p file)
	  (setq-local file buffer-file-name))
  (message "run code: %s" file)
  (cond 
   ((string-match "\.js$" file) 
	(async-shell-command (encode-coding-string (concat "nodemon " file) yzs/encode)))
   ((string-match "\.ts$" file) 
	(async-shell-command (encode-coding-string (concat "nodemon " file) yzs/encode)))
   (t (message "Can't run this file"))))

;; (defun yzs/open-directory(path) 
;;   "打开目标文件夹"
;;   (interactive "DOpen Directory:")
;;   (if (not path)
;; 	  (setq path default-directory))
;;   (message "open directory:%s" (expand-file-name path))
;;   (cond 
;;    ((string-equal system-type "windows-nt") 
;; 	(shell-command-to-string
;; 	 (encode-coding-string 
;; 	  (replace-regexp-in-string "/" "\\\\" (concat "explorer.exe " (expand-file-name path)))
;; 	  yzs/encode)))
;;    ((string-equal system-type "gnu/linux") 
;; 	(shell-command-to-string
;; 	 (encode-coding-string 
;; 	  (replace-regexp-in-string "/" "\\\\\\\\" (concat "explorer.exe " (yzs/tool/path-wsl-to-windows path)))
;; 	  yzs/encode)))
;;    ))

(defun yzs/open-directory(file)
  "Open FILE externally using the default application of the system."
  (interactive "fOpen externally: ")
  (if (and (eq system-type 'windows-nt)
		   (fboundp 'w32-shell-execute))
	  (shell-command-to-string (encode-coding-string (replace-regexp-in-string "/" "\\\\"
																			   (format "explorer.exe %s" (file-name-directory (expand-file-name file)))) 'gbk))
	(call-process yzs/which-system-open-command
				  nil 0 nil
				  (file-name-directory (expand-file-name file)))))

(defun yzs/program-exists-p (program dir-list)
  (let ((flag nil) (dir (car dir-list)))
	(unless (not dir)
	  (if (file-exists-p (concat dir "/" program))
		  (setq flag t)
		(setq flag (yzs/program-exists-p program (cdr dir-list)))))
	flag)
  )

(defun yzs/display-startup-time ()
  "显示启动时间和垃圾包的数量"
  (interactive)
  (message "Emacs loaded in %s with %d garbage collections"
		   (format "%.2f secends" 
				   (float-time 
					(time-subtract after-init-time before-init-time)))
		   gcs-done))

(defun yzs/resize-frame ()
  "重新调整frame"
  (interactive)
  (cond 
   ((string-equal system-type "windows-nt") (progn 
											  (set-frame-position (selected-frame) 0 0)
											  (set-frame-width  (selected-frame) 140)
											  (set-frame-height (selected-frame) 40)))
   ((string-equal system-type "gnu/linux") (progn 
											 (set-frame-position (selected-frame) 100 100)
											 (set-frame-width  (selected-frame) 160)
											 (set-frame-height (selected-frame) 40)))))

;;hook
(add-hook 'emacs-startup-hook 'yzs/display-startup-time)


(provide 'emacs-custom-config)
