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
set ruler
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

autocmd FileType vim setlocal commentstring=\"\ %s

set hlsearch
set incsearch
set ignorecase
set smartcase
set wildmenu
set wildmode=list:longest,full
set whichwrap=b,s,h,l,<,>,[,]
set wildignore+=.final_builds/*,*/tmp/*,*/node_modules/*,*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,.sass-cache,*.class,*.scssc,*/Godeps/*

let g:mapleader=','

if has('nvim')
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


" package settings

let g:SuperTabDefaultCompletionType = "<c-n>"

let g:javascript_plugin_jsdoc = 1

" fzf
augroup FzfOnEnter
	autocmd!
	autocmd StdinReadPre * let s:std_in=1
	 autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | call fzf#vim#files($PWD) | endif
augroup END

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

" nnoremap <silent> <C-p> :exe 'Files ' . FindRootDirectory()<CR>
nmap <C-p> :Files<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>e :BTags<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>f :Rg<CR>

" ale
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

" gutentags
let g:gutentags_file_list_command = {
	\ 'markers': {
	\ '.git': 'git ls-files',
	\ '.hg': 'hg files',
	\ },
\ }

let g:gutentags_ctags_exclude = [
	\ 'package.json',
	\ 'package-lock.json',
\]
