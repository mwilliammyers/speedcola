" let g:neomake_go_enabled_makers = ['go']
autocmd! BufWritePost * Neomake
" open list automatically but preserve cursor position
let g:neomake_open_list = 2
let g:neomake_list_height = 5
