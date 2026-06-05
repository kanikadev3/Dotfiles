;;; programming.el --- pack -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;; Code:
;; ;; EVIL MODE
;; (setq evil-want-keybinding nil)
;; ;; Download Evil
;; (unless (package-installed-p 'evil)
;;   (package-install 'evil))
;; ;; Enable Evil
;; (require 'evil)
;; (evil-mode 1)
;; ;;multi cursors
;; (use-package evil-mc
;;   :ensure t
;;   :hook (after-init . global-evil-mc-mode))
;; ;;better keybinds (for eg magit)
;; (use-package evil-collection
;;   :ensure t
;;   :after evil
;;   :init (evil-collection-init))

;; multible cursors 2
(use-package multiple-cursors
  :ensure t)
 (unless (package-installed-p 'meow)                           ;;
   (package-install 'meow))                                    ;;
 (require 'meow)                                               ;;
 (defun meow-setup ()                                          ;;
   (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty) ;;
   (meow-motion-overwrite-define-key                           ;;
    '("j" . meow-next)                                         ;;
    '("k" . meow-prev)                                         ;;
    '("/" . consult-line)                                      ;;
    )                                                          ;;
   (setq meow-selection-command-fallback                       ;;
         '((meow-change . meow-change-char)                    ;;
           ;; (meow-kill . meow-c-k)                           ;;
           ;; (meow-kill . meow-delete)                           ;;
           ;; (meow-cancel-selection . keyboard-quit)          ;;
           (meow-cancel-selection . ignore)                    ;;
           (meow-pop-selection . meow-pop-grab)                ;;
           (meow-beacon-change . meow-beacon-change-char)))    ;;
   (meow-leader-define-key                                     ;;
    ;; spc j/k will run the original command in motion state.  ;;
    '("j" . "h-j")                                             ;;
    '("k" . "h-k")                                             ;;
    '("/" . "h-/")                                             ;;
    ;; use spc (0-9) for digit arguments.                      ;;
    '("1" . meow-digit-argument)                               ;;
    '("2" . meow-digit-argument)                               ;;
    '("3" . meow-digit-argument)                               ;;
    '("4" . meow-digit-argument)                               ;;
    '("5" . meow-digit-argument)                               ;;
    '("6" . meow-digit-argument)                               ;;
    '("7" . meow-digit-argument)                               ;;
    '("8" . meow-digit-argument)                               ;;
    '("9" . meow-digit-argument)                               ;;
    '("0" . meow-digit-argument)                               ;;
    '("/" . meow-keypad-describe-key)                          ;;
    '("?" . meow-cheatsheet))                                  ;;
   (meow-normal-define-key                                     ;;
    '("0" . meow-expand-0)                                     ;;
    '("9" . meow-expand-9)                                     ;;
    '("8" . meow-expand-8)                                     ;;
    '("7" . meow-expand-7)                                     ;;
    '("6" . meow-expand-6)                                     ;;
    '("5" . meow-expand-5)                                     ;;
    '("4" . meow-expand-4)                                     ;;
    '("3" . meow-expand-3)                                     ;;
    '("2" . meow-expand-2)                                     ;;
    '("1" . meow-expand-1)                                     ;;
    '(")" . meow-forward-slurp)                                ;;
    '("(" . meow-forward-barf)                                 ;;
    '("{" . meow-backward-slurp)                               ;;
    '("}" . meow-backward-barf)                                ;;
    '("-" . negative-argument)                                 ;;
    '(";" . meow-reverse)                                      ;;
    '("," . meow-inner-of-thing)                               ;;
    '("." . meow-bounds-of-thing)                              ;;
    '("[" . meow-beginning-of-thing)                           ;;
    '("]" . meow-end-of-thing)                                 ;;
    '("a" . meow-append)                                       ;;
    '("b" . meow-back-word)                                    ;;
    '("B" . backward-word)                                     ;;
    ;; '("B" . meow-back-symbol)                               ;;
    '("c" . meow-change)                                       ;;
    ;; '("d" . meow-delete)                                    ;;
    '("d" . meow-kill)                                         ;;
    ;; '("D" . meow-backward-delete)                           ;;
    '("e" . meow-next-word)                                    ;;
    '("E" . forward-word)                                      ;;
    ;; '("E" . meow-next-symbol)                               ;;
    '("f" . meow-find)                                         ;;
    ;; '("F" . isearch-forward)                                ;;
    '("g" . meow-join)                                         ;;
    ;; '("G" . meow-grab)                                      ;;
    '("h" . meow-left)                                         ;;
    '("H" . meow-left-expand)                                  ;;
    '("i" . meow-insert)                                       ;;
    '(":a" . meow-left)                                        ;;
    '(":b" . meow-right)                                       ;;
    ;; '("I" . meow-open-above)                                ;;
    '("j" . meow-next)                                         ;;
    '("J" . meow-next-expand)                                  ;;
    '("k" . meow-prev)                                         ;;
    '("K" . meow-prev-expand)                                  ;;
    '("l" . meow-right)                                        ;;
    '("L" . meow-right-expand)                                 ;;
    '("m" . avy-goto-char-timer)                               ;;
    '("n" . meow-search)                                       ;;
    '("o" . meow-open-below)                                   ;;
    '("O" . meow-open-above)                                   ;;
    ;; '("o" . meow-block)                                     ;;
    ;; '("O" . meow-to-block)                                  ;;
    '("p" . meow-yank)                                         ;;
    '("q" . meow-quit)                                         ;;
    '("Q" . meow-goto-line)                                    ;;
    '("r" . meow-replace)                                      ;;
    '("R" . meow-swap-grab)                                    ;;
    '("s" . meow-grab)                                         ;;
    ;; '("s" . meow-kill)                                      ;;
    '("t" . meow-till)                                         ;;
    '("u" . meow-undo)                                         ;;
    '("U" . undo-redo)                                         ;;
    ;;'("U" . meow-undo-in-selection)                          ;;
    ;; '("v" . meow-visit)                                     ;;
    '("v" . meow-block)                                        ;;
    '("V" . meow-to-block)                                     ;;
    '("/" . consult-line)                                      ;;
    '("?" . comment-dwim)                                      ;;
    '("w" . meow-mark-word)                                    ;;
    '("W" . meow-mark-symbol)                                  ;;
    '("x" . meow-line)                                         ;;
    '("X" . meow-line-expand)                                  ;;
    '("y" . meow-save)                                         ;;
    '("Y" . meow-sync-grab)                                    ;;
    '("z" . meow-pop-selection)                                ;;
    '("'" . repeat)                                            ;;
    '("<escape>" . meow-cancel-selection)                      ;;
    '("%" . meow-query-replace)                                ;;
    '("&" . meow-query-replace-regexp)                         ;;
    ))                                                         ;;
 (meow-setup)                                                  ;;
 (meow-global-mode 1)

;; ;;todo god mode
;; (use-package god-mode
;;   :ensure t)

;; (use-package evil-god-state
;;   :ensure t
;;   :after (evil god-mode))
;; ;; Press SPC in normal state for one God-mode command
;; (evil-define-key 'normal global-map
;;   (kbd "SPC")
;;   #'evil-execute-in-god-state)

;; ;; ESC exits god state
;; (evil-define-key 'god global-map
;;   [escape]
;;   #'evil-god-state-bail)

;;(unless (package-installed-p 'god-mode)
;;(package-install 'god-mode))
;;(require 'god-mode)
;;(god-mode)

;; undo tree
;(setq evil-undo-system 'undo-redo)   ;; Emacs 28+ native undo/redo
;; or
;(setq evil-undo-system 'undo-tree)   ;; Vim-like tree (most common)
;; or
;(setq evil-undo-system 'undo-fu)     ;; lightweight alternative
(use-package undo-tree
  :ensure t
  :hook (after-init . global-undo-tree-mode))
;; (evil-set-undo-system 'undo-tree) 

;; Prevent undo tree files from polluting your git repo
(setq undo-tree-history-directory-alist '(("." . "~/.config/emacs/undo")))

;; tree sitter (built in?)
;;(unless (package-installed-p 'tree-sitter)
;(package-install 'tree-sitter))
;(require 'tree-sitter)
;(unless (package-installed-p 'tree-sitter-langs)
;(package-install 'tree-sitter-langs))
;(require 'tree-sitter-langs)
;(global-tree-sitter-mode)
(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;;USE php-ts-mode-install-parsers etc
;; handled by treesit-auto
;; (setq treesit-language-source-alist
;;    '((bash "https://github.com/tree-sitter/tree-sitter-bash")
;;      (cmake "https://github.com/uyha/tree-sitter-cmake")
;;      (css "https://github.com/tree-sitter/tree-sitter-css")
;;      (elisp "https://github.com/Wilfred/tree-sitter-elisp")
;;      (go "https://github.com/tree-sitter/tree-sitter-go")
;;      (rust "https://github.com/tree-sitter/tree-sitter-rust")
;;      (html "https://github.com/tree-sitter/tree-sitter-html")
;;      (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
;;      (json "https://github.com/tree-sitter/tree-sitter-json")
;;      (make "https://github.com/alemuller/tree-sitter-make")
;;      (markdown "https://github.com/ikatyang/tree-sitter-markdown")
;;      (python "https://github.com/tree-sitter/tree-sitter-python")
;;      (php "https://github.com/tree-sitter/tree-sitter-php")
;;      (toml "https://github.com/tree-sitter/tree-sitter-toml")
;;      (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
;;      (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
;;      (yaml "https://github.com/ikatyang/tree-sitter-yaml")))
;; (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
;; (add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))
;; (add-to-list 'auto-mode-alist '("\\.php\\'" . php-ts-mode))
;; (add-to-list 'auto-mode-alist '("\\.py\\'" . python-ts-mode))
;; (setq treesit-language-source-alist
;;       '((phpdoc "https://github.com/claytonrcarter/tree-sitter-phpdoc")
;;         (jsdoc "https://github.com/tree-sitter/tree-sitter-jsdoc")))

;;todo lsp mode
(use-package lsp-mode
  :ensure t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (typescript-ts-mode . lsp-deferred)
         (tsx-ts-mode . lsp-deferred)
         (php-ts-mode . lsp-deferred)
         (rust-ts-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)
;(use-package lsp-tailwindcss
;    :ensure t
;  :after lsp-mode
;  :init
;  (setq lsp-tailwindcss-add-on-mode t))

;;errors
(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

;; optionally
;;(unless (package-installed-p 'lsp-ui)
;;(package-install 'lsp-ui))
;;(use-package lsp-ui
;;  :ensure t
;;  :disabled t)
;;(lsp-ui-mode -1)
;; (use-package lsp-ui :commands lsp-ui-mode)
;;alt eglot: install the lsp on your machine and configure it here
;;(use-package eglot
;;  :hook ((typescript-ts-mode tsx-ts-mode js-ts-mode) . eglot-ensure))

;;autocomplete
(use-package company
  :ensure t
  :defer 2
  :diminish
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay .1)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t))

(use-package company-box
  :ensure t
  :after company
  :diminish
  :hook (company-mode . company-box-mode))

;;indent behavior
(setq-default indent-tabs-mode nil) ;;use spaces instead of tabs
(electric-indent-mode -1) ;;disable atrocious electric indent 
(global-set-key (kbd "RET") #'newline-and-indent) ;;dumb indent on new line
(setq tab-always-indent nil) ;;remap tab to add indents 
(setq tab-width 4)

;;todo magit
(unless (package-installed-p 'magit)
  (package-install 'magit))
;;todo vterm
(use-package vterm
  :ensure t
  :config
(setq shell-file-name "/bin/sh"
      vterm-max-scrollback 5000))

;;todo verb mode
;; (use-package verb
;;   :ensure t
;;   :bind (("C-c C-r" . verb-command-map))
;;   :config
;;   (setq verb-auto-kill-response-buffers t))

;; (package-vc-install "https://github.com/JasZhe/hurl-mode")
;; (use-package hurl-mode :mode "\\.hurl\\'")

(use-package logview
  :ensure t)

(provide 'programming)
;;; programming.el ends here
