" =======================================
" Opinionated Vim/Neovim config
" Assumes you use the XDG base directory system
"
" Maintained By:
" William Myers @mkwmms [http://github.com/mkwmms/vimfiles]
"
" Initially based on:
" Luan Santos' vimfiles [https://github.com/luan/vimfiles]
" Steve Francia's legendary vim distribution [https://github.com/spf13/spf13-vim]
" =======================================

if !has('nvim')
  set nocompatible
endif

let g:mapleader = ","

" Environment
if empty("$XDG_CACHE_HOME")
  let $XDG_CACHE_HOME="$HOME/.cache"
endif

if empty("$XDG_CONFIG_HOME")
  let $XDG_CONFIG_HOME="$HOME/.config"
endif

if empty("$XDG_DATA_HOME")
  let $XDG_DATA_HOME="$HOME/.local/share"
endif

" Global variables used throughout this config
let g:vim_config_home = $XDG_CONFIG_HOME . '/vim/'
let g:vim_data_home   = $XDG_DATA_HOME . '/vim/'
let g:vim_cache_home  = $XDG_CACHE_HOME . '/vim/'

" ----------------------------------------
" Runtime Configuration
" ----------------------------------------

set directory=$XDG_CACHE_HOME/vim,~/,/tmp
set backupdir=$XDG_CACHE_HOME/vim,~/,/tmp
set viminfo+=n$XDG_CACHE_HOME/vim/viminfo
set undodir=$XDG_CACHE_HOME/vim/undo,~/,/tmp
set runtimepath=$XDG_CONFIG_HOME/vim,$XDG_DATA_HOME/vim/plugged,$XDG_CONFIG_HOME/vim/after,$VIM,$VIMRUNTIME
" let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc

if filereadable(g:vim_config_home . 'vimrc.local.before')
  source g:vim_config_home . 'vimrc.local.before'
endif

runtime! Plug.vim

runtime! config/*.vim

" ----------------------------------------
" Plugin Configuration
" ----------------------------------------

runtime! config/plugin/*.vim

if has('nvim')
  runtime! config/plugin/nvim/*.vim
else
  runtime! config/plugin/vim/*.vim
endif

" ----------------------------------------
" Lib load path
" ----------------------------------------

runtime! lib/*.vim

if filereadable(g:vim_config_home . 'vimrc.local')
  source g:vim_config_home . 'vimrc.local'
endif
