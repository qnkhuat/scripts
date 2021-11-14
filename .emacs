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

    ;; Enhances M-x to allow easier execution of commands. Provides
    ;; a filterable list of possible commands in the minibuffer
    ;; http://www.emacswiki.org/emacs/Smex
    smex

    ;; highlight matching parentheses
    highlight-parentheses                                   

    ;; Make ido display vertically
    ido-vertical-mode

    ;; project navigation
    projectile

    ;; colorful parenthesis matching
    rainbow-delimiters

    ;; better windows navigation
    ace-window

    ;; vim mode
    evil

    org

    ;; git integration
    magit))

(if (eq system-type 'darwin)
    (add-to-list 'my-packages 'exec-path-from-shell))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; --------------------------------
;; Config: Display
;; --------------------------------
(xterm-mouse-mode 1) ;; Enable mouse

(setq enable-local-variables nil) ;; Disable the warning at the start

(global-display-line-numbers-mode)

;; --------------------------------
;; Config: editing
;; --------------------------------

;; --------------------------------
;; Config: mapping
;; --------------------------------

(define-key global-map (kbd "RET") 'newline-and-indent) ; auto indent

;; --------------------------------
;; Config: evil
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

;; --------------------------------
;; Config: windowmove
;; --------------------------------
;(global-set-key (kbd "C-j") 'windmove-right)
;(global-set-key (kbd "C-k") 'windmove-down)

;; --------------------------------
;; Config: projectile
;; --------------------------------
(projectile-mode +1)
(define-key projectile-mode-map (kbd "M-f") 'projectile-command-map)

;; --------------------------------
;; Config: Ido mode
;; --------------------------------
(setq ido-enable-flex-matching t)
(ido-mode 1)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

;; --------------------------------
;; Config: smex
;; --------------------------------
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; --------------------------------
;; Config: customize
;; --------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ag smex rainbow-delimiters projectile paredit magit ido-vertical-mode ido-completing-read+ helm exec-path-from-shell evil clojure-mode-extra-font-locking cider)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
