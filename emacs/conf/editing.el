;; highlight matching parens
(show-paren-mode 1)

;; highlight current line
(global-hl-line-mode 1)

;; company mode auto complete
(add-hook 'after-init-hook 'global-company-mode)

;; don't use hard tabs
(setq-default indent-tabs-mode nil)


;;;
;; ido related
;;;

(defvar ido-cur-item nil)
(defvar ido-default-item nil)
(defvar ido-cur-list nil)

(ido-mode t)
(ido-ubiquitous-mode 1)

;; fuzzy match
(setq ido-enable-flex-matching t)

;; include buffer names of recently opened files
(setq ido-use-virtual-buffers t)

;; shows a list of buffers
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; set up smex
(setq smex-save-file (concat user-emacs-directory ".smex-items"))
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)


