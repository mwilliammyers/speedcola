nmap <leader>so :OpenSession<CR>
nmap <leader>ss :SaveSesssion! <CR> 
nmap <leader>sc :CloseSession<CR>

let g:session_directory = g:vim_data_home . 'sessions'

let g:session_command_aliases = 1

let g:session_autosave = 'yes'
let g:session_autosave_periodic = 1

let g:session_autoload = 'yes'
let g:session_default_to_last = 1

" every Vim instance without an explicit session loaded will 
" overwrite the default session (the last Vim instance wins)
" let g:session_default_overwrite = 1
