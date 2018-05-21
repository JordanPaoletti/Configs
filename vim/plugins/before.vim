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
Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale'
Plug 'leafgarland/typescript-vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'

call plug#end()

