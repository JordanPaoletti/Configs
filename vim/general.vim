"""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""

set nocompatible
set nobackup

"how many lines of history VIM has to remember
set history=250

"Enable filetype plugins
filetype plugin on
filetype indent on

"auto read when a file is changed from the outside
set autoread

"map leader
let mapleader = ","

"quick saving
nmap <leader>w :w!<cr>

"escape remap
inoremap jk <esc>
vnoremap jk <esc> 

"insert mode commands
inoremap <C-u> <esc>g~iwea

"leader  based commands
nnoremap <leader>cm :!make 
nnoremap <leader>cc :!
nnoremap <leader>U g~iw
nnoremap <leader>u g~iwe
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
