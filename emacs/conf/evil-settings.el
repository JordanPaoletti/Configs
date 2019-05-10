;; various settings for evil mode

(evil-mode 1)

(setq-default evil-escape-key-sequence "jk")

;; allow moving cursor beyond last char for better repl interaction
(setq evil-move-beyond-eol t)

(evil-escape-mode)
