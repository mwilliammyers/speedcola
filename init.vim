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

command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

autocmd FileType vim setlocal commentstring=\"\ %s

set hlsearch
set incsearch
set ignorecase
set smartcase
set wildmenu
set wildmode=list:longest,full
set whichwrap=b,s,h,l,<,>,[,]
set wildignore+=.svn,.hg,.bzr,.git
set wildignore+=*/tmp/*,*/node_modules/*,.sass-cache,*.class,*.scssc,*/Godeps/*
set wildignore+=.final_builds/*,*.o,*.obj,*.exe,*.so,*.dll,*.pyc

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


"
" package settings
"

let g:SuperTabDefaultCompletionType = "<c-n>"

let g:javascript_plugin_jsdoc = 1

"
" fzf
"
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

nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Leader>t :Files<CR>
nnoremap <silent> <Leader>g :GFiles<CR>
nnoremap <silent> <Leader>gs :GFiles?<CR>
nnoremap <silent> <Leader><Enter> :Buffers<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
" nnoremap <silent> <Leader> :Colors<CR>
nnoremap <silent> <Leader>l :Lines<CR>
nnoremap <silent> <Leader>ll :BLines<CR>
nnoremap <silent> <Leader>r :Tags<CR>
nnoremap <silent> <Leader>rr :BTags<CR>
nnoremap <silent> <Leader>` :Marks<CR>
nnoremap <silent> <Leader>w :Windows<CR>
nnoremap <silent> <Leader>o :Locate<CR>
nnoremap <silent> <Leader>q :History<CR>
nnoremap <silent> <Leader>q: :History:<CR>
nnoremap <silent> <Leader>q/ :History/<CR>
nnoremap <silent> <Leader>s :Snippets<CR>
nnoremap <silent> <Leader>c :Commits<CR>
nnoremap <silent> <Leader>cc :BCommits<CR>
nnoremap <silent> <Leader>: :Commands<CR>
nnoremap <silent> <Leader>m :Maps<CR>
nnoremap <silent> <Leader>h :Helptags<CR>
nnoremap <silent> <Leader>tp :Filetypes<CR>

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
" ale
"
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
	\ '*': ['remove_trailing_lines', 'trim_whitespace'],
	\ 'python': ['pyls', 'yapf', 'isort'],
	\ 'javascript': ['eslint', 'prettier'],
\}

" TODO: according to docs all enabled linters are used but this isn't working
let g:ale_linters = {
	\ 'python': ['pyls', 'vulture', 'mypy'],
	\ 'javascript': ['eslint', 'prettier'],
\}

"
" gutentags
"
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
