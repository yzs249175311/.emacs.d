(defvar yzs/run-code-command-alist
  '(
	("c" . yzs/c-run-code-command)
	("js" . yzs/js-run-code-command)
	("ts" . (yzs/ts-run-code-command yzs/ts-run-code-command-esm yzs/ts-run-code-command-tsx yzs/ts-run-code-command-tsx-watch))
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

(defun yzs/ts-run-code-command-esm (file)
  (let* (
		 (filename (expand-file-name file))
		 (filepath (file-name-directory filename))
		 )
	(concat "ts-node-esm " filename))
  )

(defun yzs/ts-run-code-command-tsx (file)
  (let* (
		 (filename (expand-file-name file))
		 (filepath (file-name-directory filename))
		 )
	(concat "tsx " filename))
  )

(defun yzs/ts-run-code-command-tsx-watch (file)
  (let* (
		 (filename (expand-file-name file))
		 (filepath (file-name-directory filename))
		 )
	(concat "tsx watch " filename))
  )

(provide 'custom-run-code-command)
