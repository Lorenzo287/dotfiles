;; Additional personal settings loaded after init.el

;; Helper functions for package management
(defvar rc/package-contents-refreshed nil
  "Track if package contents have been refreshed this session.")

(defun rc/package-refresh-contents-once ()
  "Refresh package contents only once per session."
  (unless rc/package-contents-refreshed
    (setq rc/package-contents-refreshed t)
    (package-refresh-contents)))

(defun rc/require-one-package (package)
  "Install PACKAGE if not already installed."
  (unless (package-installed-p package)
    (rc/package-refresh-contents-once)
    (package-install package)))

(defun rc/require (&rest packages)
  "Install multiple PACKAGES if not already installed."
  (dolist (package packages)
    (rc/require-one-package package)))

(defun rc/require-theme (theme)
  "Install and load THEME, assuming package name is THEME-theme."
  (let ((theme-package (intern (concat (symbol-name theme) "-theme"))))
    (rc/require theme-package)
    (load-theme theme t)))

;;; Example usage:
;; Uncomment and modify as needed

;; Install and load a theme
;; (rc/require-theme 'gruvbox)
;; (rc/require-theme 'doom-one)
;; (rc/require-theme 'zenburn)

;; Install multiple packages at once
;; (rc/require 'magit 'company 'flycheck)

;; Add your personal settings below:
;; ===================================

;; Example: Set your name and email
;; (setq user-full-name "Your Name"
;;       user-mail-address "your.email@example.com")

;; Example: Custom keybindings
;; (global-set-key (kbd "C-c g") 'magit-status)

;; Example: Mode-specific settings
;; (add-hook 'prog-mode-hook #'hs-minor-mode) ; Code folding

(provide 'rc)
;;; rc.el ends here
