packadd onedark.vim
set termguicolors
colorscheme onedark

set hidden

set mouse=a

set number relativenumber
set splitright
set splitbelow
set colorcolumn=80,120
set signcolumn=yes
set nowrap

set undofile
set undolevels=1000

set listchars=tab:▸\ ,eol:\ ,trail:·

set shiftwidth=2
set softtabstop=2
set tabstop=2

set smartcase
set wildmode=list:longest,full
set whichwrap=b,s,h,l,<,>,[,]
set wildignore+=.svn,.hg,.bzr,.git
set wildignore+=*/tmp/*,*/node_modules/*,.sass-cache,*.class,*.scssc,*/Godeps/*
set wildignore+=.final_builds/*,*.o,*.obj,*.exe,*.so,*.dll,*.pyc

let g:mapleader=','

tnoremap <Esc> <C-\><C-n>

command! -bang -nargs=? -complete=file E e<bang> <args>
command! -bang -nargs=? -complete=file W w<bang> <args>
command! -bang -nargs=? -complete=file Wq wq<bang> <args>
command! -bang -nargs=? -complete=file WQ wq<bang> <args>
command! -bang WQA wqa<bang>
command! -bang WQa wqa<bang>
command! -bang Wqa wqa<bang>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang XA xa<bang>
command! -bang Xa xa<bang>


"
" package settings
"

com! PackUpdate ru! packages.vim | call minpac#update('', {'do': 'helpt ALL'})
com! PackClean ru! packages.vim | call minpac#clean()

let g:SuperTabDefaultCompletionType = '<c-n>'

let g:javascript_plugin_jsdoc = 1

nnoremap <F5> :MundoToggle<Return>
nnoremap <Leader>u :MundoToggle<Return>

let g:jsx_ext_required = 1

let g:airline_theme='onedark'

let g:prettier#autoformat = 0
let g:prettier#exec_cmd_async = 1

"
" fzf
"
autocmd StdinReadPre * let s:reading_stdin=1
autocmd VimEnter * nested
      \  if argc() == 0 && !exists("s:reading_stdin")
      \|  call fzf#vim#files(getcwd())
      \| endif

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
      \ 'prefix': '^.*$',
      \ 'source': 'rg -n ^ --color always',
      \ 'options': '--ansi --delimiter : --nth 3..',
      \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))

nnoremap <silent> <Leader>f :Rg<Return>
nnoremap <silent> <C-t> :Files<Return>
nnoremap <silent> <Leader>t :Files<Return>
nnoremap <silent> <Leader>tg :GFiles<Return>
nnoremap <silent> <Leader>tg? :GFiles?<Return>
nnoremap <silent> <Leader><Enter> :Buffers<Return>
nnoremap <silent> <Leader>b :Buffers<Return>
" nnoremap <silent> <Leader> :Colors<Return>
nnoremap <silent> <Leader>l :Lines<Return>
nnoremap <silent> <Leader>ll :BLines<Return>
nnoremap <silent> <Leader>r :Tags<Return>
nnoremap <silent> <Leader>rr :BTags<Return>
nnoremap <silent> <Leader>` :Marks<Return>
nnoremap <silent> <Leader>w :Windows<Return>
nnoremap <silent> <Leader>o :Locate<Return>
nnoremap <silent> <Leader>q :History<Return>
nnoremap <silent> <Leader>q: :History:<Return>
nnoremap <silent> <Leader>q/ :History/<Return>
nnoremap <silent> <Leader>sn :Snippets<Return>
nnoremap <silent> <Leader>c :Commits<Return>
nnoremap <silent> <Leader>cc :BCommits<Return>
nnoremap <silent> <Leader>: :Commands<Return>
nnoremap <silent> <Leader>m :Maps<Return>
nnoremap <silent> <Leader>h :Helptags<Return>
nnoremap <silent> <Leader>tp :Filetypes<Return>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment']
      \}

"
" fugitive
"
nnoremap <silent> <leader>Gs :Gstatus<Return>
nnoremap <silent> <leader>Gd :Gdiff<Return>
nnoremap <silent> <leader>Gc :Gcommit<Return>
nnoremap <silent> <leader>Gb :Gblame<Return>
nnoremap <silent> <leader>Gl :Glog<Return>
nnoremap <silent> <leader>Gp :Git push<Return>
nnoremap <silent> <leader>Gr :Gread<Return>
nnoremap <silent> <leader>Gw :Gwrite<Return>
nnoremap <silent> <leader>Ge :Gedit<Return>
nnoremap <silent> <leader>Gi :Git add -p %<Return>

"
" ale
"
nmap <silent> <Leader>af <Plug>(ale_fix)
nmap <silent> <C-S-c> <Plug>(ale_fix)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <Leader>ar <Plug>(ale_rename)
nmap <silent> <Leader>gR <Plug>(ale_rename)
nmap <silent> <Leader>ai :ALEInfo<Return>

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:airline#extensions#ale#enabled = 1
let g:ale_completion_enabled = 1

let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']}

"
" vim-lsc
"
" let g:lsc_server_commands = {
"       \ 'rust': 'rustup run stable rls',
"       \ 'javascript': 'javascript-typescript-stdio',
"       \ 'javascript.jsx': 'tcp://127.0.0.1:2089',
"       \}

" let g:lsc_auto_map = v:true
