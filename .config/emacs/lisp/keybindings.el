;;; keybindings.el --- pack -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
;; Zoom in and out
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)
;; USE XCLIP ??
;; (global-set-key (kbd "C-c t x") #'xterm-mouse-mode) 

(global-set-key (kbd "C-c t e") #'evil-mode)
(global-set-key (kbd "C-c c") 'comment-line)

;; search and replace, could also do C-c s r
(global-set-key (kbd "C-c r") 'query-replace)
(global-set-key (kbd "C-c R") 'query-replace-regexp)   

(defun my/reload-config ()
  (interactive)
  (load-file "~/.config/emacs/init.el")
  (ignore (elpaca-process-queues)))
(global-set-key (kbd "C-c e r") #'my/reload-config)  

(defun my/open-config ()
  (interactive)
  (find-file user-init-file))
(global-set-key (kbd "C-c e e") #'my/open-config)
(provide 'keybindings)
;;; keybindings.el ends here
