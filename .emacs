;; --------------------------------
;; Install package
;; --------------------------------

;; Define package repositories
(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)
(add-to-list 'package-pinned-packages '(magit . "melpa-stable") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages
  '(;; makes handling lisp expressions much, much easier
    ;; Cheatsheet: http://www.emacswiki.org/emacs/PareditCheatsheet
    paredit

    ;; key bindings and code colorization for Clojure
    ;; https://github.com/clojure-emacs/clojure-mode
    clojure-mode

    ;; extra syntax highlighting for clojure
    clojure-mode-extra-font-locking

    ;; integration with a Clojure REPL
    ;; https://github.com/clojure-emacs/cider
    cider

    ;; highlight matching parentheses
    highlight-parentheses                                   

    ;; Make ido display vertically
    ido-vertical-mode

    ;; improved of iod
    ivy
    counsel

    ;; project navigation
    projectile

    ;; colorful parenthesis matching
    rainbow-delimiters

    ;; vim mode
    evil
    evil-tabs

    org
    ;; theme
    spacemacs-theme

    ;; git integration
    magit))

(if (eq system-type 'darwin)
    (add-to-list 'my-packages 'exec-path-from-shell))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; --------------------------------
;; config-Display
;; --------------------------------
(xterm-mouse-mode 1) ;; Enable mouse
(menu-bar-mode -1) ;; turn off menubar

(setq enable-local-variables nil) ;; Disable the warning at the start

(global-display-line-numbers-mode)
(load-theme 'spacemacs-dark t)

;; --------------------------------
;; config-editting
;; --------------------------------
(setq default-directory ".")

;; --------------------------------
;; config-mapping
;; --------------------------------

(define-key global-map (kbd "RET") 'newline-and-indent) ; auto indent

;; --------------------------------
;; config-cider
;; --------------------------------
(global-set-key (kbd "C-c C-d v") 'cider-find-var)

;; --------------------------------
;; config-use-package
;; --------------------------------
(require 'use-package)

;; --------------------------------
;; config-rainbow-delimeters
;; --------------------------------
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; --------------------------------
;; config-evil
;; --------------------------------
(require 'evil)
(evil-mode 1)
(evil-ex-define-cmd "q" 'kill-this-buffer) ;; :q to kill tab
(evil-ex-define-cmd "qa" 'evil-quit)       ;; :qa to kill emacs

(define-key evil-normal-state-map "H" "10h")
(define-key evil-normal-state-map "J" "10j")
(define-key evil-normal-state-map "K" "10k")
(define-key evil-normal-state-map "L" "10l")
(define-key evil-normal-state-map "q" "^")
(define-key evil-normal-state-map "e" "$")
(define-key evil-visual-state-map "H" "10h")
(define-key evil-visual-state-map "J" "10j")
(define-key evil-visual-state-map "K" "10k")
(define-key evil-visual-state-map "L" "10l")
(define-key evil-visual-state-map "q" "^")
(define-key evil-visual-state-map "e" "$")

(global-evil-tabs-mode t)

;; --------------------------------
;; config-ido
;; --------------------------------
(setq ido-enable-flex-matching t)
(ido-mode 1)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

;; --------------------------------
;; config-ivy
;; --------------------------------
(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

(defvar find-file-root-dir (getenv "PWD")
  "Directory from which to start all find-file's")

(defun find-file-in-root ()
  "Make find-file always start at some root directory."
  (interactive)
  (let ((default-directory find-file-root-dir))
    (call-interactively 'counsel-fzf)))

(global-set-key (kbd "C-c C-p") 'find-file-in-root)
(global-set-key (kbd "C-c C-f") 'counsel-ag)

;; --------------------------------
;; config-customize
;; --------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default))
 '(package-selected-packages
   '(ag smex rainbow-delimiters projectile paredit magit ido-vertical-mode ido-completing-read+ helm exec-path-from-shell evil clojure-mode-extra-font-locking cider)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; --------------------------------
;; mode-clojure
;; --------------------------------
(defun setup-clojure-buffer ()
  ;; Count hyphens, etc. as word characters in lisps
  (modify-syntax-entry ?- "w" clojure-mode-syntax-table))

(add-hook 'clojure-mode-hook 'setup-clojure-buffer)
