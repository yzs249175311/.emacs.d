;;; custom-run-code-command.el --- generate code command  -*- lexical-binding:t -*-

;;; Commentary:

;;; Code:

;;用于存储文件扩展名和获取生成文件命令函数对应的表
(defvar yzs/run-code-command-alist
  '(
	("html" . (yzs/open-file-in-live-server yzs/open-file-in-system))
	))

(defun yzs/get-run-code-command (file)
  "获取运行代码的命令.
FILE 表示文件的完整路径"
  (let ((command (alist-get
				  (file-name-extension file)
				  yzs/run-code-command-alist
				  nil nil 'string-equal
				  )))

	(when (and (listp command) command)
	  (setq command (intern (completing-read "Select Command:" (mapcar (lambda (item) (format "%s" item)) command)))))

	(cond
	 ((and (commandp command) (symbolp command)) command)
	 ((fboundp command) (funcall command file)))
	))

(defmacro yzs/generate-run-code-command-macro (file-extension function-name command option)
  "生成函数，函数用于生成执行命令.
FILE-EXTENSION 表示文件的后缀名,是字符串.
FUNCTION-NAME 表示定义的函数的名字名.
COMMAND 表示可执行的命令.
OPTION 表示命令的选项."

  `(progn
	 (defun ,function-name (file)
	   (if (executable-find ,command)
		   (let* (
				  (filename (expand-file-name file))
				  (filepath (file-name-directory filename))
				  (filebase (file-name-base filename))
				  )
			 (concat ,command " " ,@option))
		 (prog1
			 nil
		   (message "No %s,you need install it!" ,command))
		 ))

	 (let ((p-cons (assoc ,file-extension yzs/run-code-command-alist #'string-equal)))
	   (if p-cons
		   (cond
			((listp (cdr p-cons)) (setf (cdr p-cons) (cons (quote ,function-name) (cdr p-cons))))
			((symbolp (cdr p-cons)) (setf (cdr p-cons) (list (quote ,function-name) (cdr p-cons))))
			)
		 (push (cons ,file-extension (quote ,function-name)) yzs/run-code-command-alist)))
	 )
  )

(yzs/generate-run-code-command-macro "c" yzs/c-run-code-command "gcc" (filename " -o " filepath  filebase " && " filepath filebase))
(yzs/generate-run-code-command-macro "js" yzs/js-run-code-command "node" (filename))
(yzs/generate-run-code-command-macro "ts" yzs/ts-run-code-command "ts-node" (filename))
(yzs/generate-run-code-command-macro "ts" yzs/ts-run-code-command-esm "ts-node-esm" (filename))
(yzs/generate-run-code-command-macro "ts" yzs/ts-run-code-command-tsx "tsx" (filename))
(yzs/generate-run-code-command-macro "ts" yzs/ts-run-code-command-tsx-watch "tsx" ("watch " filename))

(provide 'custom-run-code-command)

;;; custom-run-code-command.el ends here
