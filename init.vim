packadd onedark.vim
if has('termguicolors') | set termguicolors | endif
colorscheme onedark

set hidden

set mouse=a

set number relativenumber
set splitright
set splitbelow
set colorcolumn=80,120
if has('signcolumn') | set signcolumn=yes | endif
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

set completeopt+=longest,menuone,noselect
set shortmess+=c

let g:mapleader=','

if exists(':tnoremap')
  tnoremap <Esc> <C-\><C-n>
endif

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

let g:javascript_plugin_jsdoc = 1

nnoremap <F5> :MundoToggle<Return>
nnoremap <Leader>u :MundoToggle<Return>

let g:jsx_ext_required = 1

let g:airline_theme='onedark'

let g:neoformat_basic_format_trim = 1

" TODO: extract this and XDG logic in vimrc to a package
if empty($XDG_CACHE_HOME) | let $XDG_CACHE_HOME=expand('~/.cache') | endif
let g:gutentags_cache_dir = $XDG_CACHE_HOME . '/tags'
let g:gutentags_ctags_exclude = ['package*.json', '*config.json']

let g:sneak#label = 1

"
" fzf
"
autocmd StdinReadPre * let s:reading_stdin=1
autocmd VimEnter * nested
  \  if argc() == 0 && !exists("s:reading_stdin")
  \|  call fzf#vim#files(getcwd())
  \| endif

if executable('rg')
  inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
    \ 'prefix': '^.*$',
    \ 'source': 'rg -n ^ --color always',
    \ 'options': '--ansi --delimiter : --nth 3..',
    \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))

  nnoremap <silent> <Leader>f :Rg<Return>
end

nnoremap <silent> <C-t> :Files<Return>
nnoremap <silent> <Leader>t :Files<Return>
nnoremap <silent> <Leader>tg :GFiles<Return>
nnoremap <silent> <Leader>tg? :GFiles?<Return>
nnoremap <silent> <Leader><Enter> :Buffers<Return>
nnoremap <silent> <Leader>b :Buffers<Return>
" nnoremap <silent> <Leader> :Colors<Return>
nnoremap <silent> <Leader>l :Lines<Return>
nnoremap <silent> <Leader>ll :BLines<Return>
nnoremap <silent> <Leader>y :Tags<Return>
nnoremap <silent> <Leader>yy :BTags<Return>
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
" vim-lsc 
"
let g:lsc_auto_map = v:true

let g:lsc_server_commands = {
  \ 'rust': 'rls',
  \ 'javascript': 'javascript-typescript-stdio',
  \ 'python': 'pyls',
  \ }

"
" devdocs.vim
"
nmap L <Plug>(devdocs-under-cursor)

let g:devdocs_filetype_map = {
    \   'javascript': 'javascript',
    \   'javascript.jsx': 'react',
    \   'javascript.test': 'jest',
    \   'sql': 'postgresql',
    \   'dockerfile': 'postgresql',
    \ }

command! -nargs=* DevDocsReact call devdocs#open_doc(<q-args>, 'react')

