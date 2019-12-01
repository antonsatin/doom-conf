;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;; (setq projectile-generic-command "fd . -0 --type file --hidden --color=never")


(global-set-key (kbd "s-o") 'other-window)

(evil-ex-define-cmd "q" 'kill-current-buffer)
(evil-ex-define-cmd "quit" 'evil-quit)
(evil-ex-define-cmd "wq" 'evil-save-and-close)
(evil-ex-define-cmd "ls" 'ivy-switch-buffer)
(evil-ex-define-cmd "fp" 'projectile-find-file)
(evil-ex-define-cmd "ff" 'find-file)
(evil-ex-define-cmd "sip" 'projectile-ag)
(evil-ex-define-cmd "neo" 'neotree-toggle)
(evil-ex-define-cmd "gst" 'magit-status)

(setq-hook! 'typescript-mode-hook typescript-indent-level 2)
(setq-hook! 'javascript-mode-hook js-indent-level 2)

(toggle-frame-fullscreen)
