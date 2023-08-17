;;; emacs-custom-config.el --- custom config -*- lexical-binding:t -*-

;;; Commentary:

;;; Code:
(require 'custom-run-code-command)

;;------------------ define variable -------------------------------;;
(setq use-wsl-p nil)
(setq yzs/which-system-open-command (pcase system-type
									  ('darwin "open")
									  ('cygwin "cygstart")
									  (_ "xdg-open")))

(setq yzs/encode
	  (pcase system-type
		('windows-nt 'gbk)
		(_ 'utf-8)))

;;------------------ define macro -------------------------------;;

;;------------------ define function -------------------------------;;

(defun yzs/tool/path-wsl-to-windows (path)
  "将wsl的路径转换为windows平台的路径.
PATH 表示路径的字符串。"
  (if use-wsl-p
	  (replace-regexp-in-string "\/mnt\/\\(\\w+\\)" "\\1\:" path)
	str)
  )

;;open my init.el file
(defun yzs/open-init ()
  "打开emacs的init.el文件."
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
  "用操作系统默认的方式打开文件.
FILE 表示文件的完整路径."

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
  "创建服务器打开此文件,需要使用npm安装browser-sync.
DIR 表示创建的服务器跟目录.
STARTPATH 表示启动服务器后,打开的文件."

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
  "运行代码,支持的文件格式在 `yzs/run-code-command-alist' 中.
FILE 表示文件的完整路径."

  (interactive "fChoice file:")
  (unless (file-exists-p file)
	(setq-local file buffer-file-name))
  (message "Run file: %s" file)
  (let ((command (yzs/get-run-code-command file)))
	(if command
		(progn
		  (message "Try to run command:%s" command)
		  (cond
		   ((stringp command) (async-shell-command (encode-coding-string command yzs/encode)))
		   ((commandp command) (call-interactively command))))
	  (message "Can't run this file"))))

(defun yzs/run-current-code ()
  "运行当前文件的代码,支持的文件格式在 `yzs/run-code-command-alist' 中."
  (interactive)
  (if (buffer-file-name)
	  (let ((command (yzs/get-run-code-command (buffer-file-name))))
		(if command
			(progn
			  (message "Try to run command:%s" command)
			  (cond
			   ((stringp command) (async-shell-command (encode-coding-string command yzs/encode)))
			   ((commandp command) (call-interactively command))))
		  (message "Can't run this file")))
	(message "Can't run buffer,only file!")))

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

(defun yzs/display-startup-time ()
  "显示启动时间和垃圾包的数量."
  (interactive)
  (message "Emacs loaded in %s with %d garbage collections"
		   (format "%.2f secends"
				   (float-time
					(time-subtract after-init-time before-init-time)))
		   gcs-done))

(defun yzs/toggle-proxy()
  "开关代理."
  (interactive)
  (if (bound-and-true-p url-proxy-services)
	  (progn
		(setq url-proxy-services nil)
		(message "Disable proxy"))

	(progn
	  (setq url-proxy-services
			'(("https" . "localhost:7890")
			  ("http" . "localhost:7890")))
	  (message "Enable proxy")))
  )


(defun yzs/resize-frame ()
  "重新调整frame."
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
;;; emacs-custom-config.el ends here
