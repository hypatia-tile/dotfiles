;; Hide the Start Screen (Splash Screen)
(setq inhibit-startup-screen t)

(menu-bar-mode -1) ; Hide menu bar

;; Display line number
(global-display-line-numbers-mode t)

;; Hilite current cursor line
(global-hl-line-mode t)

;; Re-bind help command
(global-set-key (kbd "M-?") 'help-command)
(global-set-key (kbd "C-x ?") 'help-command)

(add-to-list 'auto-mode-alist '("\\.foo\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.notes\\'" . org-mode))

;; Set the default directory for auto-save files
(setq auto-save-file-name-transforms
      `((".*" , (expand-file-name "auto-save/" user-emacs-directory) t)))

;; If the auto-save directory does not exist, create it
(let ((dir (expand-file-name "auto-save/" user-emacs-directory)))
  (unless (file-exists-p dir)
    (make-directory dir t)))

;; Set the default directory for backup files
(setq auto-save-file-name-transforms
      `((".*" , (expand-file-name "backup/" user-emacs-directory) t)))

;; If the backup directory does not exist, create it
(let ((dir (expand-file-name "backup/" user-emacs-directory)))
  (unless (file-exists-p dir)
    (make-directory dir t)))
