"""""""""""""""""""""""""""""""""""""""""
" _Plugins config
"""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""
" _Contents
"""""""""""""""""""""""""""""""""""""""""
" search any of the following words

" _Fzf
" _LightLine
" _Ale

"""""""""""""""""""""""""""""""""""""""""
" _Fzf
"""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fc :Commits<cr>
nnoremap <leader>fb :Buffers<cr>
nnoremap <leader>fl :Lines<cr>

"""""""""""""""""""""""""""""""""""""""""
" _LightLine
"""""""""""""""""""""""""""""""""""""""""
set laststatus=2

if !has('gui_running')
    set t_Co=256
endif

"""""""""""""""""""""""""""""""""""""""""
" _Ale
"""""""""""""""""""""""""""""""""""""""""
let g:ale_lint_on_text_changed=0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1

"leader access to other features
nnoremap <leader>ad :ALEGoToDefinition<cr>
nnoremap <leader>ar :ALEFindReferences<cr>
nnoremap <leader>ah :ALEHover<cr>
nnoremap <leader>ai :ALEInfo<cr>
nnoremap <leader>at :ALEToggle<cr>

"omnicompletion
let g:ale_completion_enabled = 1

