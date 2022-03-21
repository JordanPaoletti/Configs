
;; define package repositories
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "https://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("tromey" . "https://tromey.com/elpa/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; install packages

(setq package-list
      '(
         ;;;
         ;; UI
         ;;;

         ;; https://melpa.org/#/monokai-theme
         ; UI / code color theming
         monokai-theme

         ;; https://github.com/nschum/highlight-symbol.el
         ; highlights current cursor symbol
         highlight-symbol

         ;; https://github.com/bbatsov/projectile
         ; commands for finding/navigating files as a project
         projectile

         ;;;
         ;; editing
         ;;;

         ;; http://company-mode.github.io/
         ; Text completion framework
         company

         ;; https://github.com/DarwinAwardWinner/ido-completing-read-plus
         ; ui for auto completions
         ido-completing-read+

         ;; https://github.com/nonsequitur/smex
         ; convenient interface fo M-x commands
         smex

         ;;;
         ;; evil
         ;;;

         ;; https://github.com/emacs-evil/evil
         ; vi emulation
         evil

         ;; https://github.com/syl20bnr/evil-escape
         ; remap the escape key sequence for evil
         evil-escape

         ;;;
         ;; general lisp
         ;;;

         ;; https://github.com/Fanael/rainbow-delimiters
         ; use various colors to match delimiters: (, {, [ etc
         rainbow-delimiters

         ;; https://www.emacswiki.org/emacs/ParEdit
         ; convenient manual parenthesis editing tools
         paredit

         ;;;
         ;; common lisp
         ;;;

         ;; https://github.com/slime/slime
         ; common lisp repl integration
         slime

         ;;;
         ;; clojure
         ;;;

         ;; https://github.com/clojure-emacs/clojure-mode
         ; provides clojure language support
         clojure-mode

         ;; https://github.com/clojure-emacs/clojure-mode/blob/master/clojure-mode-extra-font-locking.el
         ; extra syntax highlighting
         clojure-mode-extra-font-locking

         ;; https://github.com/clojure-emacs/cider
         ; Clojure repl integration
         cider

         ))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; load from conf directory
(add-to-list 'load-path "~/.emacs.d/conf")
(load "ui.el")
(load "evil-settings.el")
(load "setup-clojure.el")
(load "editing.el")
(load "misc.el")
(load "common-lisp.el")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (clj-refactor cider paredit rainbow-delimiters evil-escape evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
