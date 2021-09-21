;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Add the standard repositories for Emacs packages
;; https://emacsredux.com/blog/2014/05/16/melpa-stable/
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t);; Set up MELPA
;; Refresh the emacsclient with `emacsclient -e "(kill-emacs)"`

;; Backup features
;; https://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files/18330742#18330742
(defvar --backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p --backup-directory))
        (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      delete-old-versions t             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 2               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 3               ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 20              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 200            ; number of keystrokes between auto-saves (default: 300)
      )


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (magit flycheck company lsp-ui lsp-mode cl-lib eldoc go-eldoc auto-complete go-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Enable LSP Mode
(require 'lsp-mode)
(add-hook 'go-mode-hook #'lsp-deferred)

;; Load path for GoCode
;; https://github.com/nsf/gocode
;; The GoCode binary needs to be installed and on
;; $PATH first
;; (add-to-list 'load-path "~/.emacs.d/golang")
;; (require 'go-autocomplete)
;; (require 'auto-complete-config)
;; (ac-config-default)

;; Setup go-eldoc
;; https://github.com/emacsorphanage/go-eldoc
(require 'go-eldoc) ;; Don't need to require, if you install by package.el
(add-hook 'go-mode-hook 'go-eldoc-setup)

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
;; https://github.com/golang/tools/blob/master/gopls/doc/emacs.md
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; Add Flycheck
;; https://www.flycheck.org/en/latest/user/installation.html
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
;; Enable syntax checking with Flycheck
;; https://www.flycheck.org/en/latest/user/quickstart.html
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Enable line numbers mode for all
;; programming modes
;; https://emacs.stackexchange.com/questions/278/how-do-i-display-line-numbers-in-emacs-not-in-the-mode-line
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Set a global key for compile with a Makefile
;; https://emacs.stackexchange.com/questions/17280/how-to-set-up-hotkey-for-compiling-c-code-and-run-the-compiled-file
(global-set-key [f4] 'compile)
