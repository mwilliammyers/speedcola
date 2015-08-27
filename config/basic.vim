" ----------------------------------------
" Regular Vim Configuration (No Plugins Needed)
" ----------------------------------------

" Config {{{
set undofile

set swapfile         " Keep swapfiles

" }}}

" UI {{{
set nu               " Line numbers on
set nowrap           " Line wrapping off
set cmdheight=2      " Make the command area two lines high
set numberwidth=5
set encoding=utf-8
set guioptions=acg
set splitright      " Puts new vsplit windows to the right of the current
set splitbelow      " Puts new split windows to the bottom of the current
set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
set cursorline
if !has('nvim')
  set ttyfast
endi
set lazyredraw
if exists('+colorcolumn')
  set colorcolumn=80 " Color the 80th column differently
endif

if !has('nvim')
  if has("mouse_sgr")
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  end
end
" }}}

" Behaviors {{{
"set autoindent            " Indent at the same level of the previous line
filetype plugin indent on  " Automatically detect file types. (must turn on after Vundle)
set wildmode=list:longest  " use emacs-style tab completion when selecting files, etc
set hidden                 " Change buffer - without saving
set autowriteall           " Writes on make/shell commands
set foldmethod=syntax
set foldlevel=20
set formatoptions=crql
set iskeyword+=$,@,-       " Add extra characters that are valid parts of variables
set tags=./tags;/,tags;/
set nojoinspaces           " Prevents inserting two spaces after punctuation on a join (J)
" }}}

" Text Format {{{
set tabstop=2
set shiftwidth=2  " Tabs under smart indent
set expandtab     " Tabs are spaces, not tabs
" }}}

" Searching {{{
set ignorecase
set smartcase  " Non-case sensitive search
set hlsearch
set wildignore+=.final_builds/*,*/tmp/*,*/node_modules/*,*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,.sass-cache,*.class,*.scssc,*/Godeps/*
if executable('ack')
  set grepprg=ack\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow\ $*
  set grepformat=%f:%l:%c:%m
endif
if executable('ag')
  set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
  set grepformat=%f:%l:%c:%m
endif
" }}}

" Visual {{{
set showmatch   " Show matching brackets.
set matchtime=2 " How many tenths of a second to blink
" }}}

" Sounds {{{
set noerrorbells
set novisualbell
" }}}

" Mouse {{{
set mousehide  " Hide mouse after chars typed
set mouse=a  " Mouse in all modes
" }}}
