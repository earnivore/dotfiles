;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Manually install use-package to improve
;; init.el readability
;; https://melpa.org/#/getting-started

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
   '(lsp-python-ms rainbow-delimiters smartparens treemacs company-box magit flycheck company lsp-ui lsp-mode cl-lib eldoc go-eldoc auto-complete go-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Enable LSP Mode
;; https://emacs-lsp.github.io/lsp-mode/page/installation/#use-package
(use-package lsp-mode
  :ensure t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  ;;(add-hook 'go-mode 'lsp)

  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
	 ;; Python LSP will need to be installed with
	 ;; `pip install python-lsp-server` (A maintained fork of pyls)
         (python-mode . lsp-deferred)
         (go-mode . lsp-deferred)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred))

;; optionally
(use-package lsp-ui
	     :ensure t
	     :commands lsp-ui-mode)

;; Enable go-mode.el
(use-package go-mode
	     :ensure t
	     :init
	     (add-hook 'before-save-hook 'gofmt-before-save)
	     (add-hook 'go-mode-hook (lambda ()
				       (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
	     (add-hook 'go-mode-hook (lambda ()
				       (local-set-key (kbd "C-c i") 'go-goto-imports)))
	     (add-hook 'go-mode-hook (lambda ()
				       (local-set-key (kbd \"M-.\") 'godef-jump)))
	     ;;(add-hook 'go-mode-hook 'lsp-deferred)
	     )

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

;; Add Company Box
;; https://github.com/sebastiencs/company-box/

;; (use-package company-box
;; 	     :ensure t
;;   :hook (company-mode . company-box-mode))

;; Add Company Mode
(use-package company
	     :ensure t
	     :init
	     (add-hook 'after-init-hook 'global-company-mode)
	     :config
	     ;; FIXME
	     ;;(setq company-format-margin-function #'company-vscode-dark-icons-margin)
	     (setq company-minimum-prefix-length 1 company-idle-delay 0.0) ;; default is 0.2
	     )
(setq company-format-margin-function #'company-detect-icons-margin)




;; Enable line numbers mode for all
;; programming modes
;; https://emacs.stackexchange.com/questions/278/how-do-i-display-line-numbers-in-emacs-not-in-the-mode-line
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Enable which-key
;; https://github.com/justbur/emacs-which-key/#melpa
(use-package which-key
  :ensure t
  )

;; Enable Magit
(use-package magit
  :ensure t
  :defer t)

;; Enable smart parentheses
;; https://github.com/MCotocel/dotfiles/blob/main/config/emacs/emacs.org#parentheses
(use-package smartparens
  :ensure t
  :config (smartparens-global-mode)
  (show-smartparens-mode))

;; Enable rainbow parentheses
;; https://github.com/MCotocel/dotfiles/blob/main/config/emacs/emacs.org#parentheses
(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; Add Treemacs
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   t
          treemacs-file-event-delay                5000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-width                           35
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

;; Set a global key for compile with a Makefile
;; https://emacs.stackexchange.com/questions/17280/how-to-set-up-hotkey-for-compiling-c-code-and-run-the-compiled-file
(global-set-key [f4] 'compile)

