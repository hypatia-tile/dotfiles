(require 'package)

(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'ddskk)
  (package-install 'ddskk))

;; SKK
(require 'skk)
(setq skk-large-jisyo "~/.config/skk/SKK-JISYO.L")
(global-set-key (kbd "C-x C-j") #'skk-mode)
(global-set-key (kbd "C-x j") #'skk-auto-fill-mode)

;; Org
;; (setq org-startup-indented t)
;; (setq org-hide-emphasis-markers t)
;; (setq org-startup-with-inline-images t)
;; (add-hook 'org-mode-hook #'visual-line-mode)

;; Hide the Start Screen (Splash Screen)
(setq inhibit-startup-screen t)

(menu-bar-mode -1) ; Hide menu bar

;; Disable toolbar, menu bar, and scroll bar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

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

;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; Reload this file with:
;; M-x load-file RET ~/.emacs.d/init.el RET
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(ddskk)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
