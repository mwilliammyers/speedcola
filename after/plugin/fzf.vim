" fun! s:fzf_root()
  " let path = finddir(".git", expand("%:p:h").";")
  " return fnamemodify(substitute(path, ".git", "", ""), ":p:h")
" endfun

nnoremap <silent> <C-p> :exe 'Files ' . <SID>FindRootDirectory()<CR>
nnoremap <silent> <Leader>o :exe 'Files ' . <SID>FindRootDirectory()<CR>
nnoremap <silent> <Leader>fo :exe 'Files ' . <SID>FindRootDirectory()<CR>
nnoremap <silent> <Leader>ff :exe 'Files ' . <SID>fzf_root()<CR>

nnoremap <silent> <leader>m :Mru<cr>
nnoremap <silent> <leader>fm :Mru<cr>

nnoremap <silent> <leader>gf :GitFiles<cr>
nnoremap <silent> <leader>fgf :GitFiles<cr>

nnoremap <silent> <leader>a :Ag<cr>
nnoremap <silent> <leader>fa :Ag<cr>

nnoremap <silent> <leader>ho :History<cr>
nnoremap <silent> <leader>fho :History<cr>
nnoremap <silent> <leader>hc :History:<cr>
nnoremap <silent> <leader>fhc :History:<cr>
nnoremap <silent> <leader>hs :History/<cr>
nnoremap <silent> <leader>fhs :History/<cr>

nnoremap <silent> <leader>m :Marks<cr>
nnoremap <silent> <leader>fm :Marks<cr>

nnoremap <silent> <leader>bt :BTags<cr>
nnoremap <silent> <leader>bt :BTags<cr>
nnoremap <silent> <leader>t :Tags<cr>
nnoremap <silent> <leader>ft :Tags<cr>

nnoremap <silent> <leader>bl :BLines<cr>
nnoremap <silent> <leader>fbl :BLines<cr>
nnoremap <silent> <leader>l :Lines<cr>
nnoremap <silent> <leader>fl :Lines<cr>

nnoremap <silent> <leader>b :Buffers<cr>
nnoremap <silent> <leader>fb :Buffers<cr>

nnoremap <silent> <leader>w :Windows<cr>
nnoremap <silent> <leader>fw :Windows<cr>

nnoremap <silent> <leader>gc :Commits<cr>
nnoremap <silent> <leader>fgc :Commits<cr>
nnoremap <silent> <leader>gbc :BCommits<cr>
nnoremap <silent> <leader>fgbc :BCommits<cr>

nnoremap <silent> <leader>fco :Commands<cr>

nnoremap <silent> <leader>ma :Maps<cr>
nnoremap <silent> <leader>fma :Maps<cr>

nnoremap <silent> <leader>C :Colors<cr>
nnoremap <silent> <leader>fC :Colors<cr>

" open FZF automatically when vim starts up if no files were specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && empty($COLA_DATA_HOME . '/sessions') | call fzf#vim#files($PWD) | endif
