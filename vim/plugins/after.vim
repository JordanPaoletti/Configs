"""""""""""""""""""""""""""""""""""""""""
" _Plugins config
"""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""
" _Contents
"""""""""""""""""""""""""""""""""""""""""
" search any of the following words

" _Fzf
"
"""""""""""""""""""""""""""""""""""""""""
" _Fzf
"""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fc :Commits<cr>
nnoremap <leader>fb :Buffers<cr>
nnoremap <leader><tab> <plug>(fzf-maps-n)
xnoremap <leader><tab> <plug>(fzf-maps-x)
onoremap <leader><tab> <plug>(fzf-maps-o)
