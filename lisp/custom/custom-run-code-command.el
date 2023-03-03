(defvar yzs/run-code-command-alist
  '(
	("c" . yzs/c-run-code-command)
	("js" . yzs/js-run-code-command)
	("ts" . yzs/ts-run-code-command)
	))

(defun yzs/c-run-code-command (file)
  (let* (
		 (filename (expand-file-name file))
		 (filepath (file-name-directory filename))
		 (filebase (file-name-base filename))
		 )
	(concat "gcc " filename " -o " filepath  filebase " && " filepath filebase))
  )

(defun yzs/js-run-code-command (file)
  (let* (
		 (filename (expand-file-name file))
		 (filepath (file-name-directory filename))
		 )
	(concat "node " filename))
  )

(defun yzs/ts-run-code-command (file)
  (let* (
		 (filename (expand-file-name file))
		 (filepath (file-name-directory filename))
		 )
	(concat "ts-node " filename))
  )
(provide 'custom-run-code-command)
