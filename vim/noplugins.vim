
"""""""""""""""""""""""""""""""""""""""""
" _No_Plugins
"""""""""""""""""""""""""""""""""""""""""
"contains settings for noplugins vim
"contents

" _Status_Line

"""""""""""""""""""""""""""""""""""""""""
" _Status_Line
"""""""""""""""""""""""""""""""""""""""""

set laststatus=2

set statusline=%f            " Path to file
set statusline+=\ -\         " Separator
set statusline+=Type:        " Label
set statusline+=%y           " Filetype of the file
set statusline+=\ -\         " Separator
set statusline+=Buf:         " Label
set statusline+=%n           " Buffer number
set statusline+=%=           " Switch to right side
set statusline+=Line:        " Label
set statusline+=%l           " current line
set statusline+=/            " Separator
set statusline+=%-5L         " Total Lines
set statusline+=\ \          " Separator
set statusline+=Col:         " Label
set statusline+=%c\          " Column number
