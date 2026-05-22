;; TODO s ;;
;;TODO Fix the indentation stuff



;;gui cleanup
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)

;; enable package.el
(require 'package)
(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)
;;(package-refresh-contents)

;;use package should be installed by default?
;; package refresh contents updates the repos, could be done manually with m x package-refresh-contents?
;; Ensure use-package is installed
;;(unless (package-installed-p 'use-package)
  ;; (package-refresh-contents)
  ;; (package-install 'use-package))
;; enable use package
;; (require 'use-package)

;;enable which key
(which-key-mode)

;;show numbers
(global-display-line-numbers-mode 1)
(global-visual-line-mode t)

;;theme
;;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;;'(custom-enabled-themes '(tango-dark))
 ;;'(package-selected-packages nil))
;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; )

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'wombat t)) ;;set theme here
;transparency
(add-to-list 'default-frame-alist '(alpha-background . 95)) ; For all new frames henceforth

;; EVIL MODE

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)
;;multi cursors
(use-package evil-mc
  :ensure t
  :hook (after-init . global-evil-mc-mode))

;;better keybinds (for eg magit)
(use-package evil-collection
  :ensure t
  :after evil
  :init (evil-collection-init))




;; undo tree
;(setq evil-undo-system 'undo-redo)   ;; Emacs 28+ native undo/redo
;; or
;(setq evil-undo-system 'undo-tree)   ;; Vim-like tree (most common)
;; or
;(setq evil-undo-system 'undo-fu)     ;; lightweight alternative


(use-package undo-tree
    :ensure t
  :hook (after-init . global-undo-tree-mode)
  ;:init
  ;(global-undo-tree-mode 1)
  )
(evil-set-undo-system 'undo-tree)

;; Prevent undo tree files from polluting your git repo
(setq undo-tree-history-directory-alist '(("." . "~/.config/emacs/undo")))

;;(undo-tree-mode)

;; copy paste from tty to os
(use-package xclip
    :ensure t
  :hook (after-init . xclip-mode)
    )
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



(add-hook 'evil-insert-state-entry-hook (lambda () (send-string-to-terminal "\033[5 q")))
(add-hook 'evil-insert-state-exit-hook  (lambda () (send-string-to-terminal "\033[2 q")))

    ;;todo use evil collection for extra stuff

;;todo god mode
;;(unless (package-installed-p 'god-mode)
;;(package-install 'god-mode))
;;(require 'god-mode)
;;(god-mode)


;; tree sitter (built in?)
;;(unless (package-installed-p 'tree-sitter)
;(package-install 'tree-sitter))
;(require 'tree-sitter)
;(unless (package-installed-p 'tree-sitter-langs)
;(package-install 'tree-sitter-langs))
;(require 'tree-sitter-langs)
;(global-tree-sitter-mode)
;(use-package treesit-auto
;  :ensure t
;  :custom
;  (treesit-auto-install 'prompt)
;  :config
;  (treesit-auto-add-to-auto-mode-alist 'all)
;  (global-treesit-auto-mode))

;;By default, Emacs requires you to hit ESC three times to escape quit the minibuffer
(setq treesit-language-source-alist
   '((bash "https://github.com/tree-sitter/tree-sitter-bash")
     (cmake "https://github.com/uyha/tree-sitter-cmake")
     (css "https://github.com/tree-sitter/tree-sitter-css")
     (elisp "https://github.com/Wilfred/tree-sitter-elisp")
     (go "https://github.com/tree-sitter/tree-sitter-go")
     (rust "https://github.com/tree-sitter/tree-sitter-rust")
     (html "https://github.com/tree-sitter/tree-sitter-html")
     (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
     (json "https://github.com/tree-sitter/tree-sitter-json")
     (make "https://github.com/alemuller/tree-sitter-make")
     (markdown "https://github.com/ikatyang/tree-sitter-markdown")
     (python "https://github.com/tree-sitter/tree-sitter-python")
     (php "https://github.com/tree-sitter/tree-sitter-php")
     (toml "https://github.com/tree-sitter/tree-sitter-toml")
     (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
     (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
     (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-ts-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-ts-mode))

(global-set-key [escape] 'keyboard-escape-quit)

;;todo lsp mode
;;(package-install 'lsp-mode))
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
(unless (package-installed-p 'flycheck)
(package-install 'flycheck))
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

;;or disable

;; dashboard (startup)

(use-package dashboard
  :ensure t 
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
  ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  (setq dashboard-startup-banner "~/.config/emacs/images/dtmacs-logo.png")  ;; use custom image as banner
  (setq dashboard-center-content nil) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 3)
                          (projects . 3)
                          (registers . 3)))
  :custom 
  (dashboard-modify-heading-icons '((recents . "file-text")
				      (bookmarks . "book")))
  :config
  (dashboard-setup-startup-hook))

;; company (complete any command)
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

;;todo modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 35      ;; sets modeline height
        doom-modeline-bar-width 5    ;; sets right bar width
        doom-modeline-persp-name t   ;; adds perspective name to modeline
        doom-modeline-persp-icon t)) ;; adds folder icon next to persp name

;;todo verb mode
(use-package verb
  :ensure t
  :bind (("C-c C-r" . verb-command-map))
  :config
  (setq verb-auto-kill-response-buffers t))



;;todo dbml mode
;;(use-package dbml-mode
;;  :ensure t)

;;todo puml mode
;;(use-package plantuml-mode :ensure t)
;;todo set path variable and install jar file with command

;;todo db client
;;(ejc-create-connection
;; "wildlife-connection"
;; :classpath (concat "~/.m2/repository/org.postgresql/postgresql/42.6.0/"
;;                    "postgresql-42.6.0.jar")
;; :subprotocol "postgresql"
;; :subname "//localhost:5432/wildlife"
;; :user "charalambos"
;; :password "") ;;TODO env var

;;todo prespective

;;todo org mode
(setq org-agenda-files '("~/org/"))
;; active Babel languages
(org-babel-do-load-languages
'org-babel-load-languages
'((shell . t)))
(use-package ox-gfm
  :ensure t
  :after org)

;;todo neotree
(use-package neotree
  :ensure t
  :config
  (setq neo-smart-open t
        neo-show-hidden-files t
        neo-window-width 55
        neo-window-fixed-size nil
        inhibit-compacting-font-caches t
        projectile-switch-project-action 'neotree-projectile-action) 
        ;; truncate long file names in neotree
        (add-hook 'neo-after-create-hook
           #'(lambda (_)
               (with-current-buffer (get-buffer neo-buffer-name)
                 (setq truncate-lines t)
                 (setq word-wrap nil)
                 (make-local-variable 'auto-hscroll-mode)
                 (setq auto-hscroll-mode nil)))))

;;todo rainbow mode
(use-package rainbow-mode
  :ensure t
  :diminish
  :hook org-mode prog-mode)
;;todo magit
(unless (package-installed-p 'magit)
  (package-install 'magit))

;;dired 
(use-package dired-open :ensure t
  :config
  (setq dired-open-extensions '(("gif" . "sxiv")
                                ("jpg" . "sxiv")
                                ("png" . "sxiv")
                                ("mkv" . "mpv")
                                ("mp4" . "mpv"))))

(use-package peep-dired :ensure t
  :after dired
  :hook (evil-normalize-keymaps . peep-dired-hook)
  :config
    (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
    (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-open-file) ; use dired-find-file instead if not using dired-open package
    (evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file)
    (evil-define-key 'normal peep-dired-mode-map (kbd "k") 'peep-dired-prev-file)
)

;;todo vterm
(use-package vterm
  :ensure t
  :config
(setq shell-file-name "/bin/sh"
      vterm-max-scrollback 5000))

;;todo fonts

;; This sets the default font on all graphical frames created after restarting Emacs.
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
;; are not right unless I also add this method of setting the default font.
(add-to-list 'default-frame-alist '(font . "JetBrains Mono-11"))

;; Uncomment the following line if line spacing needs adjusting.
(setq-default line-spacing 0.12)
;;sane defaults
(delete-selection-mode 1)    ;; You can select text and delete it by typing.
;;(electric-indent-mode -1)    ;; Turn off the weird indenting that Emacs does by default.
            
    
(electric-pair-mode 1)       ;; Turns on automatic parens pairing
(auto-save-mode -1)
(setq-default wrap-prefix "↪ ")

;; Zoom in and out
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)
;; USE XCLIP ??
(global-set-key (kbd "C-c t x") #'xterm-mouse-mode) 

(global-set-key (kbd "C-c t e") #'evil-mode)
(global-set-key (kbd "C-c c") 'comment-line)

;; search and replace, could also do C-c s r
(global-set-key (kbd "C-c r") 'query-replace)
(global-set-key (kbd "C-c R") 'query-replace-regexp)   

 ;;custom hotkeys
(defun my/reload-config ()
  (interactive)
  (load-file "~/.config/emacs/init.el")
  (ignore (elpaca-process-queues)))
(global-set-key (kbd "C-c e r") #'my/reload-config)  

(defun my/open-config ()
  (interactive)
  (find-file user-init-file))
(global-set-key (kbd "C-c e e") #'my/open-config)


;;sett load config open config etc
;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;'(custom-safe-themes
 ;  '("aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8"
 ;    "d481904809c509641a1a1f1b1eb80b94c58c210145effc2631c1a7f2e4a2fdf4"
 ;    "f1e8339b04aef8f145dd4782d03499d9d716fdc0361319411ac2efc603249326"
 ;    default))
 ;'(package-selected-packages
 ;  '(annalist company-box consult dashboard dired-open doom-modeline
 ;             doom-themes evil-collection evil-mc flycheck git-gutter
 ;             lsp-tailwindcss magit neotree orderless peep-dired
 ;             rainbow-mode undo-tree vertico vterm xclip)))
;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
; )

;;
;;disable and reconfigure Emacs' default indent behavior 
(setq-default indent-tabs-mode nil) ;;use spaces instead of tabs
(electric-indent-mode -1) ;;disable atrocious electric indent 
(global-set-key (kbd "RET") #'newline-and-indent) ;;dumb indent on new line
(setq tab-always-indent nil) ;;remap tab to add indents 
(setq tab-width 4)

;;my stuff



;;(defun dbml-sql()
;;  "draw dbml"
;;  (interactive)
;;  (if (not buffer-file-name)
;;      (message "Buffer is not visiting a file!")
;;    (let* ((filename (shell-quote-argument buffer-file-name)) ; safely quote file name
;;           (command(format "dbml2sql %s" filename)) ;;psql by default
	   ;;(command (format "dbml-renderer -i %s" filename))   ; replace 'my-command' with your command
;;           (buffer-name "*dbml out*")
;;           (buffer (get-buffer-create buffer-name)))
      ;; Clear the buffer
 ;;     (with-current-buffer buffer
  ;;      (read-only-mode -1)
  ;;      (erase-buffer))
      ;; Run the command
  ;;    (let ((exit-code (call-process-shell-command command nil buffer t)))
        ;; Add header and make read-only
  ;;      (with-current-buffer buffer
  ;;        (goto-char (point-min))
  ;;        (insert (format "Command: %s\nExit code: %d\n\n" command exit-code))
   ;;       (read-only-mode 1))
        ;; Show the buffer
   ;;     (display-buffer buffer)))))


;;(defun dbml-draw ()
;;  "draw dbml"
;;  (interactive)
;;  (if (not buffer-file-name)
;;      (message "Buffer is not visiting a file!")
;;    (let* ((input-file (shell-quote-argument buffer-file-name))
;;           (svg-data (shell-command-to-string (format "dbml-renderer -i %s" input-file)))
 ;;          (buffer-name "*dbml preview*")
 ;;          (buffer (get-buffer-create buffer-name)))
 ;;     (with-current-buffer buffer
 ;;       (read-only-mode -1)
 ;;       (erase-buffer)
 ;;       ;; Insert SVG as image
 ;;       (insert-image (create-image svg-data 'svg t))
 ;;       (read-only-mode 1))
 ;;     (display-buffer buffer))))

;;telescope
;; orderless search
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring
;; Enable Vertico.
(use-package vertico
  :ensure t
  :custom
   (vertico-scroll-margin 0) ;; Different scroll margin
   (vertico-count 20) ;; Show more candidates
   (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
   (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init
  (vertico-mode))
;; CONSULT
;; Example configuration for Consult
(use-package consult
    :ensure t
  ;; Replace bindings. Lazily loaded by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g r" . consult-grep-match)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-find)                  ;; Alternative: consult-fd
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Tweak the register preview for `consult-register-load',
  ;; `consult-register-store' and the built-in commands.  This improves the
  ;; register formatting, adds thin separator lines, register sorting and hides
  ;; the window mode line.
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep consult-man
   consult-bookmark consult-recent-file consult-xref
   consult-source-bookmark consult-source-file-register
   consult-source-recent-file consult-source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (keymap-set consult-narrow-map (concat consult-narrow-key " ?") #'consult-narrow-help)
)
            
;;git
(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode +1))
;; todo
;;(use-package magit
;;  :ensure t)
    ;; yank highluight
(require 'pulse)

(defun my/pulse-yank-advice (&rest _)
  (pulse-momentary-highlight-region (mark) (point)))

;; Emacs yank
(advice-add 'yank :after #'my/pulse-yank-advice)
(advice-add 'yank-pop :after #'my/pulse-yank-advice)

;; Evil yank
(advice-add 'evil-yank :after #'my/pulse-yank-advice)
(advice-add 'evil-yank-line :after #'my/pulse-yank-advice)


;;backups
(setq backup-directory-alist '(("." . "~/.emacs_backups")))

;; tab bar mode
(when (< 26 emacs-major-version)
 (tab-bar-mode 1)                           ;; enable tab bar
 (setq tab-bar-show 1)                      ;; hide bar if <= 1 tabs open
 (setq tab-bar-close-button-show nil)       ;; hide tab close / X button
 (setq tab-bar-new-tab-choice "*dashboard*");; buffer to show in new tabs
 (setq tab-bar-tab-hints t)                 ;; show tab numbers
  (setq tab-bar-format '(tab-bar-format-tabs tab-bar-separator))
;; elements to include in ba
;;(xterm-mouse-mode 1)
;;     (use-package volatile-highlights
;;  :ensure t
;;  :config
;;  (volatile-highlights-mode 1))
    ;; to reload file do load_file enter enter
;; TODO rest


