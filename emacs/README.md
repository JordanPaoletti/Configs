# Setup

* download emacs from [gnu emacs](https://www.gnu.org/software/emacs/)
* add the config files to the .emacs.d folder. Windows location is `C:\Users\user-name\AppData\Roaming\.emacs.d`
* start emacs. It should automatically run init.el and download packages. 
* may require multiple restarts

## common lisp
* download [sbcl](http://www.sbcl.org/platform-table.html)
* run `M-x slime` to start the repl
* download and install [quicklisp (package manager)](https://www.quicklisp.org/beta/#installation)

## clojure
* download and install [lein](https://github.com/technomancy/leiningen)
* run `M-x cider-jack-in` in a clojure project

## cider
* `C-c M-n n` switch repl to current namespace
* `C-c C-k` evaluate source buffer in repl
* `C-c C-e` evaluate preceding form
* `C-c C-c` evaluate top level form
* `C-left/right` barf / slurp

## emacs cheat sheet 
* [cheat sheet](https://www.gnu.org/software/emacs/refcards/pdf/refcard.pdf)
* `C-x d` enter dired
* `C-x C-b` list open buffers
