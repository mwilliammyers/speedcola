set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
" set bomb
" set binary

set autoread
set nobackup
set noswapfile
" set undodir=~/.local/share/nvim/undo/
set undofile

packadd onedark.vim
set termguicolors
colorscheme onedark

syntax on
set rulerla
set number relativenumber
set splitright
set splitbelow
set colorcolumn=80
set laststatus=2
set listchars=tab:▸\ ,eol:\ ,trail:·
set list
set signcolumn=yes
set backspace=indent,eol,start
set autoindent
set complete-=i
set smarttab

set shiftwidth=2
set softtabstop=2
set tabstop=2
" set expandtab
autocmd FileType make setlocal noexpandtab
autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab

set hlsearch
set incsearch
set ignorecase
set smartcase
set wildmenu
" set wildmode=list:longest,full
" set whichwrap=b,s,h,l,<,>,[,]
" set wildignore+=.final_builds/*,*/tmp/*,*/node_modules/*,*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,.sass-cache,*.class,*.scssc,*/Godeps/*

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


nmap <C-F>f <Plug>CtrlSFPrompt
vmap <C-F>f <Plug>CtrlSFVwordPath
vmap <C-F>F <Plug>CtrlSFVwordExec
nmap <C-F>n <Plug>CtrlSFCwordPath
nmap <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

nnoremap <silent> <C-p> :exe 'Files ' . FindRootDirectory()<CR>
augroup FzfOnEnter
	autocmd!
	autocmd StdinReadPre * let s:std_in=1
	 autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | call fzf#vim#files($PWD) | endif
augroup END

nmap <leader>af <Plug>(ale_fix)
nmap <leader>ap <Plug>(ale_previous_wrap)
nmap <leader>an <Plug>(ale_next_wrap)
" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:airline#extensions#ale#enabled = 1
let g:ale_completion_enabled = 1
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_fixers = {
\	'*': ['remove_trailing_lines', 'trim_whitespace'],
\	'python': ['pyls', 'yapf', 'isort'],
\	'javascript': ['eslint', 'prettier'],
\}
" TODO: according to docs all enabled linters are used but this isn't working
let g:ale_linters = {
\	'python': ['pyls', 'vulture', 'mypy'],
\	'javascript': ['eslint', 'prettier'],
\}

let g:SuperTabDefaultCompletionType = "<c-n>"

let g:javascript_plugin_jsdoc = 1

