;;设置窗口
(cond 
 ((string-equal system-type "windows-nt")
  (mapc #'(lambda (elm) (push elm default-frame-alist))
	'((height . 45)
	  (width . 160)
	  (left . 25)
	  (top . 25))))
 ((string-equal system-type "gnu/linux")
  (mapc #'(lambda (elm) (push elm default-frame-alist))
	'((height . 45)
	  (width . 200)
	  (left . 25)
	  (top . 25)))))

(defun yzs/set-font-faces () 
  ;;set default font
  (if (member "Noto Sans Mono CJK SC" (font-family-list))
	  (set-frame-font "Noto Sans Mono CJK SC" t t)
	(set-frame-font
	 (cond
	  ((string-equal system-type "windows-nt")
	   (cond
		((font-info "更纱黑体 Mono SC Nerd-12.0:bold") "更纱黑体 Mono SC Nerd-12.0:bold")
		((member "JetBrains Mono NL" (font-family-list)) "JetBrains Mono NL")
		((member "Consolas" (font-family-list)) "JetBrains Mono NL")))

	  ((string-equal system-type "darwin")
	   (cond
		((member "Menlo"  (font-family-list)) "Menlo-16")))

	  ((string-equal system-type "gnu/linux")
	   (cond
		((font-info "等距更紗黑體 CL Nerd Font") "等距更紗黑體 CL Nerd Font")
		((member "JetBrainsMono Nerd Font Mono" (font-family-list)) "JetBrainsMono Nerd Font Mono")
		((member "Sarasa Mono J" (font-family-list)) "Sarasa Mono J")
		((member "DejaVu Sans Mono"  (font-family-list)) "DejaVu Sans Mono")))
	  (t nil))
	 t t)
	)
  
;;  set font for chinese characters
  (set-fontset-font
   t
   'han
   ;;'han
   (cond
	((string-equal system-type "windows-nt")
	 (cond
	  ((member "Microsoft YaHei" (font-family-list)) "Microsoft YaHei")
	  ((member "Microsoft JhengHei" (font-family-list)) "Microsoft JhengHei")
	  ((member "SimHei" (font-family-list)) "SimHei")))
	((string-equal system-type "darwin")
	 (cond
	  ((member "Hei" (font-family-list)) "Hei")
	  ((member "Heiti SC" (font-family-list)) "Heiti SC")
	  ((member "Heiti TC" (font-family-list)) "Heiti TC")))
	((string-equal system-type "gnu/linux")
	 (cond
	  ((font-info "文泉驿等宽微米黑") "文泉驿等宽微米黑")
	  ((member "WenQuanYi Micro Hei" (font-family-list)) "WenQuanYi Micro Hei")
	  ))
	))

  ;;set font size
  (set-face-attribute 'default nil :height 100)
  )

;; 判断是否使用了deamon和判断是否使用的是终端
(if (daemonp)
	(add-hook 'after-make-frame-functions
			  (lambda (frame)
				(with-selected-frame frame
				  (yzs/set-font-faces))))
  ;; (add-hook 'modus-themes-after-load-theme-hook 'yzs/set-font-faces)
  (cond
   ((string-equal window-system "nil"))
   (t (add-hook 'after-init-hook 'yzs/set-font-faces)))
  )

(provide 'default-frame-font)
