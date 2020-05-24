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

(add-to-list 'auto-mode-alist '("\.tsx\'" . web-mode))

(setq doom-theme 'doom-dark+)
(setq-hook! 'typescript-mode-hook typescript-indent-level 2)
(setq-hook! 'javascript-mode-hook js-indent-level 2)
(setq-hook! 'magit-mode-hook git-commit-summary-max-length 100)
(setq-hook! 'magit-mode-hook magit-refresh-status-buffer nil)
(setq-hook! 'web-mode-hook web-mode-markup-indent-offset 2)
(setq-hook! 'web-mode-hook typescript-indent-level 2)
(setq-hook! 'typescript-mode-hook tide-format-options
            '(
              :includeCompletionsForModuleExports t
              :includeCompletionsWithInsertText t
              :allowTextChangesInNewFiles t
              :quotePreference "single"
              )
            )
(add-hook! 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode)
              (typescript-mode)
              )))

(defun copy-filename-to-clipboard ()
  "Put the current file name on the clipboard"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))

(map! :leader
      "f p"
      'copy-filename-to-clipboard)

;; (toggle-frame-fullscreen)
