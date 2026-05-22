;;; init.el --- emacs init config -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
;; enable package.el
(require 'package)
(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

;; might be unnecessary:
(package-initialize)
(unless package-archive-contents (package-refresh-contents))
;; Ensure use-package is installed
(unless (package-installed-p 'use-package)
   (package-install 'use-package))
;; enable use package
(require 'use-package)

;; Add lisp directory to load-path
(add-to-list 'load-path
             (expand-file-name "lisp" user-emacs-directory))
;; Load modules
(require 'ui)
(require 'navigation)
(require 'orgmode)
(require 'programming)
(require 'keybindings)
(require 'startup)

;;sane defaults
(delete-selection-mode 1)    ;; You can select text and delete it by typing.
(electric-pair-mode 1)       ;; Turns on automatic parens pairing
(auto-save-mode -1)
(setq-default wrap-prefix "↪ ")
;;By default, Emacs requires you to hit ESC three times to escape quit the minibuffer
(global-set-key [escape] 'keyboard-escape-quit)

;; copy paste from emacs to os (wl or x)
(use-package xclip
    :ensure t
    :hook (after-init . xclip-mode))
;; send paste from tty to OS
;; (use-package clipetty
;;   :ensure t
;;   :hook (after-init . global-clipetty-mode))
;; adjust scroll speed
(setq mouse-wheel-scroll-amount
      '(5
        ((shift) . hscroll)
        ((meta))
        ((control meta) . global-text-scale)
        ((control) . text-scale)))

;;(require 'pulse)
;;(defun my/pulse-yank-advice (&rest _)
;;  (pulse-momentary-highlight-region (mark) (point)))
;; Emacs yank
;; (advice-add 'yank :after #'my/pulse-yank-advice)
;; (advice-add 'yank-pop :after #'my/pulse-yank-advice)
;; Evil yank
;; (advice-add 'evil-yank :after #'my/pulse-yank-advice)
;; (advice-add 'evil-yank-line :after #'my/pulse-yank-advice)
;; (add-hook 'evil-insert-state-entry-hook (lambda () (send-string-to-terminal "\033[5 q")))
;; (add-hook 'evil-insert-state-exit-hook  (lambda () (send-string-to-terminal "\033[2 q")))

;;backups
(setq backup-directory-alist '(("." . "~/.emacs_backups")))

(provide 'init)
;;; init.el ends here
