;; This directory
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

;; Always display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;; Allow pasting selection outside of Emacs
(setq x-select-enable-clipboard t)

;; Lines should be 80 characters wide, not 72
(setq fill-column 80)

;; Auto refresh buffers
(global-auto-revert-mode)

;; Backup files
(setq backup-directory-alist `(("." . ,(expand-file-name
                                        (concat dotfiles-dir "backups")))))

;; Transparently open compressed files
(auto-compression-mode t)

;; Enable syntax highlighting for older Emacsen that have it off
(global-font-lock-mode t)

;; Save a list of recent files visited.
(recentf-mode 1)

;; Fill text always
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; For kicks
(defalias 'yes-or-no-p 'y-or-n-p)

;; Seed the random-number generator
(random t)

(mouse-wheel-mode t)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq visible-bell nil
      echo-keystrokes 0.1
      font-lock-maximum-decoration t
      inhibit-startup-message t
      transient-mark-mode t
      color-theme-is-global t
      delete-by-moving-to-trash t
      shift-select-mode t
      truncate-partial-width-windows nil
      uniquify-buffer-name-style 'forward
      whitespace-style '(trailing lines space-before-tab
                                  indentation space-after-tab)
      whitespace-line-column 100
      ediff-window-setup-function 'ediff-setup-windows-plain
      oddmuse-directory (concat dotfiles-dir "oddmuse")
      xterm-mouse-mode t
      save-place-file (concat dotfiles-dir "places"))

;; Trailing white-space. Just say no.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Load path
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/site-lisp/")
(add-to-list 'load-path "~/.emacs.d/site-lisp/recall-position")
(add-to-list 'load-path "~/.emacs.d/site-lisp/auto-complete")

;; Additional configuration
(require 'key-bindings)
(require 'smooth-scrolling)
(require 'git-walk)
(require 'recall-position)
(require 'go-mode-load)
(require 'go-autocomplete)

;; Autopair parens
(require 'autopair)
(autopair-global-mode) ;; to enable in all buffers
(setq autopair-blink nil) ;; no no no! NO BLINKING! NOOO!

;; Emacs server
(require 'server)
(when (and (= emacs-major-version 23)
           (= emacs-minor-version 3)
           (equal window-system 'w32))
  (defun server-ensure-safe-dir (dir) "Noop" t)) ; Suppress error "directory
                                        ; ~/.emacs.d/server is unsafe"
                                                 ; on windows.
(unless (server-running-p)
  (server-start))
