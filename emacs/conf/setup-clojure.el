;; enable paredit
(add-hook 'clojure-mode-hook 'enable-paredit-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)

;; go to REPL buffer when finished connecting
;(setq cider-repl-pop-to-buffer-on-connect t)

;; cider history
(setq cider-repl-history-file "~/.emacs.d/cider-history")

;; don't open cider error buffer
(setq cider-show-error-buffer nil)

;; wrap repl history
;(setq cider-repl-warp-history t)
