;;; orgmode.el --- pack -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;;todo org mode
(setq org-agenda-files '("~/org/"))
;; active Babel languages
(org-babel-do-load-languages
'org-babel-load-languages
'((shell . t)))
(use-package ox-gfm
  :ensure t
  :after org)
(provide 'orgmode)
;;; orgmode.el ends here
