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

;; (add-to-list 'auto-mode-alist '("\.tsx\'" . web-mode))
(add-to-list 'auto-mode-alist '("\.yml\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\.proto\'" . protobuf-mode))
(add-to-list 'auto-mode-alist '("\.po\'" . po-mode))
(add-to-list 'auto-mode-alist '("Jenkins*'" . jenkinsfile-mode))

(map! :map dired-mode-map
      "C-j" 'dired-find-alternate-file
      "C-k" 'dired-up-directory
 )

(map! :map ivy-minibuffer-map
      "C-RET" #'ivy-immediate-done
      )

(map! :leader
      "f p"
      'copy-filename-to-clipboard)
(map! :leader
      "b f"
      'lsp-format-buffer
      )

(setq doom-theme 'doom-dark+)
(setq doom-font
      (font-spec :family "Fira Code" :size 12)
      )
(setq org-pomodoro-length 30)
(setq org-pomodoro-short-break-length 10)
(setq org-pomodoro-finished-sound-p nil)
(setq org-pomodoro-short-break-sound-p nil)
(setq org-pomodoro-long-break-sound-p nil)
(setq lsp-file-watch-threshold 9000)
(setq company-minimum-prefix-length 3)

(setq-hook! 'typescript-mode-hook typescript-indent-level 2)
(setq-hook! 'typescript-mode-hook tide-format-options
            '(
              :includeCompletionsForModuleExports t
              :includeCompletionsWithInsertText t
              :allowTextChangesInNewFiles t
              :quotePreference "single"
              )
            )
(setq-hook! 'javascript-mode-hook js-indent-level 2)
(setq-hook! 'magit-mode-hook git-commit-summary-max-length 100)
(setq-hook! 'magit-mode-hook magit-refresh-status-buffer nil)
;; (setq-hook! 'web-mode-hook web-mode-markup-indent-offset 2)
;; (setq-hook! 'web-mode-hook web-mode-code-indent-offset 2)
;; (setq-hook! 'web-mode-hook typescript-indent-level 2)

;; (setq-hook! 'elixir-mode-hook +format-with-lsp t)

(add-hook! 'elixir-mode-hook
           (add-to-list 'exec-path "~/.elixir-ls"))

;; (add-hook! 'after-save-hook (lambda () (if (eq major-mode 'elixir-mode) (lsp-format-buffer))))


;; (add-hook! 'web-mode-hook
;;           (lambda ()
;;             (when (string-equal "tsx" (file-name-extension buffer-file-name))
;;               (setup-tide-mode)
;;               (typescript-mode)
;;               )))

(after! elixir-mode (set-company-backend! 'elixir-mode nil))
;; (after! elixir-mode (set-company-backend! 'elixir-mode nil))

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

(setq projectile-generic-command "fd . -0 --type f --color=never")
(setq lsp-elixir-ls-download-url "https://github.com/elixir-lsp/elixir-ls/releases/download/v0.11.0/elixir-ls.zip")
(add-hook 'elixir-mode-hook 'copilot-mode)
;; (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (("C-TAB" . 'copilot-accept-completion-by-word)
         ("C-<tab>" . 'copilot-accept-completion-by-word)
         :map copilot-completion-map
         ("<tab>" . 'copilot-accept-completion)
         ("TAB" . 'copilot-accept-completion)))
