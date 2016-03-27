" =======================================
" speed-cola
"
" ultra fast vim configuration
" powered by vim-plug, infused with XDG and a little speed-cola
"
" Maintained By:
" William Myers @mwilliammyers [http://github.com/mwilliammyers/speed-cola]
"
" Initially based on:
" Luan Santos" vimfiles [https://github.com/luan/vimfiles]
" Steve Francia"s legendary vim distribution [https://github.com/spf13/spf13-vim]
" =======================================

let g:mapleader = ","

if &shell =~# "fish$"
  set shell=sh
endif

" ----------------------------------------
" Environment
" ----------------------------------------

" XDG directories 

if empty($XDG_CONFIG_HOME)
  let $XDG_CONFIG_HOME = "$HOME/.config"
endif

if empty($XDG_DATA_HOME)
  let $XDG_DATA_HOME = "$HOME/.local/share"
endif

if empty($XDG_CACHE_HOME)
  let $XDG_CACHE_HOME = "$HOME/.cache"
endif

if has("nvim")
  let g:cola_vim_name = "nvim"
else
  let g:cola_vim_name = "vim"
  set nocompatible
endif

" speed-cola directories 

if empty($COLA_CONFIG_HOME)
  let $COLA_CONFIG_HOME = $XDG_CONFIG_HOME . "/" . g:cola_vim_name
endif

if empty($COLA_DATA_HOME)
  let $COLA_DATA_HOME = $XDG_DATA_HOME . "/" . g:cola_vim_name
endif

if empty($COLA_CACHE_HOME)
  let $COLA_CACHE_HOME = $XDG_CACHE_HOME . "/" . g:cola_vim_name
endif

" ----------------------------------------
" Runtime configuration
" ----------------------------------------
set directory=$COLA_CACHE_HOME/swap,/tmp/
set backupdir=$COLA_CACHE_HOME/backup,/tmp
" set viminfo+=n$COLA_CACHE_HOME/viminfo
set undodir=$COLA_CACHE_HOME/undo,/tmp
set runtimepath=$COLA_CONFIG_HOME,$COLA_DATA_HOME/plugged,$VIM,$VIMRUNTIME
" let $MYVIMRC = $COLA_CONFIG_HOME . "/vimrc"

" ----------------------------------------
" Local configuration
" ----------------------------------------
runtime! local/vimrc

" ----------------------------------------
" General configuration
" ----------------------------------------
" Load plugins
runtime! config/local/Plug.vim
runtime! Plug.vim

runtime! local/config/*.vim
runtime! config/*.vim

" ----------------------------------------
" Plugin configuration
" ----------------------------------------
runtime! local/config/plugin/*.vim
runtime! config/plugin/*.vim
" vimscript is the WORST language 
" runtime! "config/plugin/" . g:cola_vim_name . "/*.vim"
if has('nvim')
  runtime! config/plugin/nvim/*.vim
else
  runtime! config/plugin/vim/*.vim
endif

" ----------------------------------------
" Library load path
" ----------------------------------------
" runtime! local/lib/*.vim
runtime! lib/*.vim
