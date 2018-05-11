"""""""""""""""""""""""""""""""""""""""""
" _Vim-plug
"""""""""""""""""""""""""""""""""""""""""

" specifies plugin directory
call plug#begin('~/.vim/plugged')

Plug 'easymotion/vim-easymotion'
Plug 'fatih/vim-go'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'

call plug#end()

