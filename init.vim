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
autocmd BufWritePre /tmp/* setlocal noundofile

set listchars=tab:▸\ ,eol:\ ,trail:·

set shiftwidth=2
set softtabstop=2
set tabstop=2

autocmd FileType make setlocal noexpandtab
autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab list
autocmd FileType markdown setlocal linebreak shiftwidth=4 tabstop=4 expandtab spell
autocmd FileType vim setlocal commentstring=\"\ %s

command! -range=% -nargs=0 Tabs2Spaces execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
command! -range=% -nargs=0 Spaces2Tabs execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

set smartcase
set wildmode=list:longest,full
set whichwrap=b,s,h,l,<,>,[,]
set wildignore+=.svn,.hg,.bzr,.git
set wildignore+=*/tmp/*,*/node_modules/*,.sass-cache,*.class,*.scssc,*/Godeps/*
set wildignore+=.final_builds/*,*.o,*.obj,*.exe,*.so,*.dll,*.pyc

let g:mapleader=","

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

command! PackUpdate runtime! packages.vim | call minpac#update()
command! PackClean runtime! packages.vim | call minpac#clean()

let g:SuperTabDefaultCompletionType = "<c-n>"

let g:javascript_plugin_jsdoc = 1

nnoremap <F5> :MundoToggle<CR>
nnoremap <Leader>u :MundoToggle<CR>

let g:jsx_ext_required = 1

let g:airline_theme='onedark'

"
" fzf
"
autocmd StdinReadPre * let s:reading_stdin=1
autocmd VimEnter * nested
	\  if argc() == 0 && !exists("s:reading_stdin")
	\|	call fzf#vim#files(getcwd()) 
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

nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <C-t> :Files<CR>
nnoremap <silent> <Leader>tf :Files<CR>
nnoremap <silent> <Leader>gf :GFiles<CR>
nnoremap <silent> <Leader>gf? :GFiles?<CR>
nnoremap <silent> <Leader><Enter> :Buffers<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
" nnoremap <silent> <Leader> :Colors<CR>
nnoremap <silent> <Leader>l :Lines<CR>
nnoremap <silent> <Leader>ll :BLines<CR>
nnoremap <silent> <Leader>t :Tags<CR>
nnoremap <silent> <Leader>tt :BTags<CR>
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
" fugitive
"
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gr :Gread<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>ge :Gedit<CR>
nnoremap <silent> <leader>gi :Git add -p %<CR>

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

"
" ale
"
nnoremap <leader>af <Plug>(ale_fix)
" nnoremap <leader>ap <Plug>(ale_previous_wrap)
" nnoremap <leader>an <Plug>(ale_next_wrap)
" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:airline#extensions#ale#enabled = 1
let g:ale_completion_enabled = 1
let g:ale_javascript_prettier_use_local_config = 1

let g:ale_fixers = {
	\ '*': ['remove_trailing_lines', 'trim_whitespace'],
	\ 'javascript': ['eslint', 'prettier'],
	\ 'graphql': ['eslint', 'prettier'],
	\ 'json': ['prettier'],
\}

"
" vim-lsc
"
let g:lsc_server_commands = {
	\ 'rust': 'rustup run stable rls',
	\ 'javascript': 'javascript-typescript-stdio',
	\ 'javascript.jsx': 'tcp://127.0.0.1:2089',
	\ 'python': 'pyls',
\ }

let g:lsc_auto_map = v:true
