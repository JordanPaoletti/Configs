"""""""""""""""""""""""""""""""""""""""""
" User Interface
"""""""""""""""""""""""""""""""""""""""""
"lines until bottom/top before screen moves vertically with j/k
set scrolloff=9

"turn on the wild menu
set wildmenu
set wildmode=longest:full,full

"turn on ruler
set ruler

"height of the command bar
set cmdheight=1

"buffer becomes hidden when it is abandoned
set hid

"Allow backspacing over everything in insert mode
set backspace=2

"searching settings
set ignorecase
set smartcase
set hlsearch
set incsearch

"don't redraw while executing macros
set lazyredraw

"magic for regex
set magic

"set indentation and tab setting
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set smarttab
set wrap
set linebreak
set tw=500

"show matching brackets
set showmatch
"blink time of matching brackets in decaseconds
set mat=2

"no sounds on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"left margin
set foldcolumn=0

"coloring and appearence
color desert
set background=dark
syntax on
set relativenumber

"file settings
set encoding=utf8
set ffs=unix,dos,mac



