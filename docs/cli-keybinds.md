# CLI Keybinds

Documenting keybindings setup via this config

## FZF

* CTRL-T - Paste the selected files onto the command line
* CTRL-R - Paste the selected command from history onto the command line
  * CTRL-R - Press again to further sort by chronological order
* `**<tab>` - fuzzy completion (context aware)



## tmux

Prefix is `CTRL-V`.

* `prefix t` - sesh session picker
* `prefix f` - fuzzy-find a window in any session and jump to it (most recently used first)
  * `CTRL-X` - kill the selected window
  * `CTRL-R` - rename the selected window

## zsh

* `ALT-S` - sesh session picker
* `ALT-W` - tmux window picker (attaches to the window when run outside tmux)
