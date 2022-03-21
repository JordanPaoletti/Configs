;; UI related configurations

;; Show line numbers
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative) ; relative line numbering

;; full path in title bar
(setq-default frame-title-format "%b (%f)")

;; no bell
(setq ring-bell-function 'ignore)

;; use theme
(load-theme 'monokai t)

;; symbol highlighting
(require 'highlight-symbol)
(global-set-key [(control f3)] 'highlight-symbol)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)
