
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
         ;; UI
         monokai-theme
         highlight-symbol
         projectile

         ;; editing
         company
         ido-ubiquitous
         smex

         ;; evil
         evil
         evil-escape

         ;; general lisp
         rainbow-delimiters
         paredit

         ;; clojure
         clojure-mode
         clojure-mode-extra-font-locking
         cider
         ;clj-refactor

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
