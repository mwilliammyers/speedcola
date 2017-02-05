" let g:tern_show_argument_hints = 'on_hold'
" let g:tern_show_signature_in_pum = 0
" autocmd FileType javascript setlocal omnifunc=tern#Complete

" let g:tern_request_timeout = 1  
" disable full signature type on autocomplete
" let g:tern_show_signature_in_pum = '0'

" add extra filetypes
" let g:tern#filetypes = [ 'js', 'javascript.jsx', 'vue', 'jsx']

" don't need these if using deoplete-ternjs?
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
