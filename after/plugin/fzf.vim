nnoremap <C-p> :FZF<cr>
nnoremap <leader>o :FZF<cr>
nnoremap <leader>fo :FZF<cr>

nnoremap <leader>m :Mru<cr>
nnoremap <leader>fm :Mru<cr>

nnoremap <leader>gf :GitFiles<cr>
nnoremap <leader>fgf :GitFiles<cr>

nnoremap <leader>a :Ag<cr>
nnoremap <leader>fa :Ag<cr>

nnoremap <leader>ho :History<cr>
nnoremap <leader>fho :History<cr>
nnoremap <leader>hc :History:<cr>
nnoremap <leader>fhc :History:<cr>
nnoremap <leader>hs :History/<cr>
nnoremap <leader>fhs :History/<cr>

nnoremap <leader>m :Marks<cr>
nnoremap <leader>fm :Marks<cr>

nnoremap <leader>bt :BTags<cr>
nnoremap <leader>bt :BTags<cr>
nnoremap <leader>t :Tags<cr>
nnoremap <leader>ft :Tags<cr>

nnoremap <leader>bl :BLines<cr>
nnoremap <leader>fbl :BLines<cr>
nnoremap <leader>l :Lines<cr>
nnoremap <leader>fl :Lines<cr>

nnoremap <leader>b :Buffers<cr>
nnoremap <leader>fb :Buffers<cr>

nnoremap <leader>w :Windows<cr>
nnoremap <leader>fw :Windows<cr>

nnoremap <leader>gc :Commits<cr>
nnoremap <leader>fgc :Commits<cr>
nnoremap <leader>gbc :BCommits<cr>
nnoremap <leader>fgbc :BCommits<cr>

nnoremap <leader>fco :Commands<cr>

nnoremap <leader>ma :Maps<cr>
nnoremap <leader>fma :Maps<cr>

nnoremap <leader>C :Colors<cr>
nnoremap <leader>fC :Colors<cr>

" open FZF automatically when vim starts up if no files were specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && empty($COLA_DATA_HOME . '/sessions') | call fzf#vim#files($PWD) | endif

