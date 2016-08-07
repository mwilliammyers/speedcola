" open list automatically but preserve cursor position
let g:neomake_open_list = 2
let g:neomake_list_height = 3

" enable languages
let g:neomake_go_enabled_makers = ['go']
let g:neomake_javascript_enabled_makers = ['eslint']

autocmd! BufWritePost * Neomake
