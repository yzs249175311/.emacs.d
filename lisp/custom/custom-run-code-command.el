(defvar yzs/run-code-command-alist
  '(
	("c" . yzs/c-run-code-command)
	("js" . yzs/jsts-run-code-command)
	("ts" . yzs/jsts-run-code-command)
	))

(defun yzs/c-run-code-command (file)
  (let* (
		 (filename (expand-file-name file))
		 (filepath (file-name-directory filename))
		 (filebase (file-name-base filename))
		 )
	(concat "gcc " filename " -o " filepath  filebase " && " filepath filebase))
  )

(defun yzs/jsts-run-code-command (file)
  (let* (
		 (filename (expand-file-name file))
		 (filepath (file-name-directory filename))
		 )
	(concat "node " filename))
  )

(provide 'custom-run-code-command)
