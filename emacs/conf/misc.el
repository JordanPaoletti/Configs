;; changes yes/no to y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; go straight to scratch buffer on startup
(setq inhibit-startup-message t)

;; better unique names for files
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; user projectile everywher
(projectile-global-mode)

