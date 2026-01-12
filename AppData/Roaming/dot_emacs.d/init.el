;;; ================================
;;; Package System
;;; ================================
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;;; ================================
;;; Paths & Custom File
;;; ================================
(defvar my-emacs-dir (expand-file-name "~/.emacs.d/"))

;; Set default directory (change to your preference)
;; (setq default-directory "~/")
(setq default-directory "c:/Users/ltumi/OneDrive/CLOUD/CODE/")

;; Keep auto-generated customizations separate
(setq custom-file (expand-file-name "custom.el" my-emacs-dir))
(load custom-file 'noerror)

;; Load personal rc file if it exists
(let ((rc-file (expand-file-name "rc.el" my-emacs-dir)))
  (when (file-exists-p rc-file)
    (load-file rc-file)))

;;; ================================
;;; UI / Appearance
;;; ================================
;; Disable UI chrome early
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq inhibit-startup-screen t)

;; Set initial frame size (wider window)
(when window-system
  (set-frame-size (selected-frame) 110 33))

;; Font
(when (find-font (font-spec :name "Iosevka NF"))
  (set-face-attribute 'default nil :family "Iosevka NF" :height 170))

;; Line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

;; Disable line numbers in some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook
                dired-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Better defaults
(setq-default
 cursor-type 'bar
 indent-tabs-mode nil
 tab-width 4
 fill-column 80
 scroll-margin 3
 scroll-conservatively 100000
 scroll-preserve-screen-position t)

;; Show matching parentheses
(show-paren-mode 1)
(setq show-paren-delay 0)

;; Window dividers
(when (fboundp 'window-divider-mode)
  (window-divider-mode 1))

;;; ================================
;;; Backup & Auto-save
;;; ================================
(setq backup-directory-alist
      `(("." . ,(expand-file-name "backups" my-emacs-dir))))
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "auto-save/" my-emacs-dir) t)))

;;; ================================
;;; Ido (Completion)
;;; ================================
(ido-mode 1)
(ido-everywhere 1)
(setq ido-enable-flex-matching t
      ido-use-filename-at-point 'guess
      ido-create-new-buffer 'always)

;;; ================================
;;; Evil Mode (Vim Emulation)
;;; ================================
(use-package evil
  :init
  (setq evil-want-C-u-scroll t
        evil-want-C-i-jump nil
        evil-respect-visual-line-mode t
        evil-want-keybinding nil)  ; Required for evil-collection
  :config
  (evil-mode 1)
  
  ;; Use Emacs state in some modes
  (dolist (mode '(custom-mode
                  eshell-mode
                  term-mode))
    (add-to-list 'evil-emacs-state-modes mode))
  
  ;; ESC quits prompts
  (global-set-key (kbd "<escape>") 'keyboard-escape-quit)
  
  ;; Leader key setup (Space as leader)
  (evil-set-leader 'normal (kbd "SPC"))
  
  ;; Leader + n: Open Dired (file manager)
  (evil-define-key 'normal 'global (kbd "<leader>n") 'dired-jump)
  
  ;; Leader + j: Compile
  (evil-define-key 'normal 'global (kbd "<leader>c") 'compile)
  
  ;; Leader + return: Run current file
  (defun my/run-current-file ()
    "Run the current file based on its extension."
    (interactive)
    (let* ((file-name (buffer-file-name))
           (file-ext (file-name-extension file-name)))
      (cond
       ((member file-ext '("c" "cpp" "cc"))
        (compile (format "gcc %s -o /tmp/a.out && /tmp/a.out" file-name)))
       ((equal file-ext "py")
        (compile (format "python3 %s" file-name)))
       ((equal file-ext "js")
        (compile (format "node %s" file-name)))
       ((equal file-ext "sh")
        (compile (format "bash %s" file-name)))
       (t (message "No run command configured for .%s files" file-ext)))))
  
  (evil-define-key 'normal 'global (kbd "<leader><return>") 'my/run-current-file)
  
  ;; Leader + w: Save file
  (evil-define-key 'normal 'global (kbd "<leader>w") 'save-buffer)
  
  ;; Leader + q: Quit window
  (evil-define-key 'normal 'global (kbd "<leader>q") 'evil-quit)
  
  ;; Leader + b: Switch buffer (like :b in Vim)
  (evil-define-key 'normal 'global (kbd "<leader>b") 'switch-to-buffer)
  
  ;; Leader + d: Kill buffer
  (evil-define-key 'normal 'global (kbd "<leader>d") 'kill-this-buffer)
  
  ;; Ctrl + h/j/k/l: Navigate between windows
  (define-key evil-normal-state-map (kbd "C-h") 'windmove-left)
  (define-key evil-normal-state-map (kbd "C-j") 'windmove-down)
  (define-key evil-normal-state-map (kbd "C-k") 'windmove-up)
  (define-key evil-normal-state-map (kbd "C-l") 'windmove-right)
  
  ;; Also work in insert mode
  (define-key evil-insert-state-map (kbd "C-h") 'windmove-left)
  (define-key evil-insert-state-map (kbd "C-j") 'windmove-down)
  (define-key evil-insert-state-map (kbd "C-k") 'windmove-up)
  (define-key evil-insert-state-map (kbd "C-l") 'windmove-right))

;; Evil-collection for better Evil integration
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;;; ================================
;;; Smex (Better M-x)
;;; ================================
(use-package smex
  :bind (("M-x" . smex)
         ("C-c C-c M-x" . execute-extended-command))
  :config
  (smex-initialize))

;;; ================================
;;; Compilation Settings
;;; ================================
;; Auto-scroll compilation buffer
(setq compilation-scroll-output t)

;; Colorize compilation output
(require 'ansi-color)
(defun my/colorize-compilation-buffer ()
  "Colorize compilation buffer output."
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))
(add-hook 'compilation-filter-hook #'my/colorize-compilation-buffer)

;;; ================================
;;; C/C++ Configuration
;;; ================================
;; Add simpc-mode directory to load-path
(add-to-list 'load-path (expand-file-name "simpc" my-emacs-dir))

;; Load simpc-mode if available
(when (locate-library "simpc-mode")
  (require 'simpc-mode)
  (add-to-list 'auto-mode-alist '("\\.c\\'" . simpc-mode))
  (add-to-list 'auto-mode-alist '("\\.h\\'" . simpc-mode))
  (add-to-list 'auto-mode-alist '("\\.cpp\\'" . simpc-mode))
  (add-to-list 'auto-mode-alist '("\\.hpp\\'" . simpc-mode)))

;;; ================================
;;; Warnings
;;; ================================
(setq warning-minimum-level :error)

(provide 'init)
