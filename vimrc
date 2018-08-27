set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

set autoread

if !exists($XDG_DATA_HOME)
	let $XDG_DATA_HOME=$HOME . "/.local/share"
endif
let s:vim_data_dir=$XDG_DATA_HOME . "/vim"

let s:backupdir=s:vim_data_dir . "/backup"
if !isdirectory(s:backupdir)
	call mkdir(s:backupdir, "p")
endif
let &backupdir=s:backupdir . "//"
set backup

let s:directory=s:vim_data_dir . "/swap"
if !isdirectory(s:directory)
	call mkdir(s:directory, "p")
endif
let &directory=s:directory . "//"

let s:undodir=s:vim_data_dir . "/undo"
if !isdirectory(s:undodir)
	call mkdir(s:undodir)
endif
let &undodir=s:undodir . "//"
set undofile

syntax on
set ruler
set laststatus=2
set listchars=tab:>\ ,trail:-,nbsp:+
" set list
set backspace=indent,eol,start
set autoindent
set complete-=i
set smarttab

set hlsearch
set incsearch
set ignorecase
set wildmenu


source init.vim
