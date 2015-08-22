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

let g:mapleader=","

" ----------------------------------------
" Runtime Configuration
" ----------------------------------------

" Files loaded in this order:
" ~/.vimrc
" Plug.vim
" User config: $XDG_CONFIG_HOME/vim/vimrc.{before, after}
" Anything matching: ~/.vim/config/*.vim
" Anything matching: ~/.vim/config/plugin/*.vim
"
" Settings:
" viminfo=n$XDG_CACHE_HOME/vim/viminfo
" undodir=$XDG_CACHE_HOME/vim/undo,~/,/tmp
" directory=$XDG_CACHE_HOME/vim/swap,~/,/tmp
" backupdir=$XDG_CACHE_HOME/vim/backup,~/,/tmp

if filereadable($XDG_CONFIG_HOME . '/vim/vimrc.before')
  source $XDG_CONFIG_HOME/vim/vimrc.before
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

if filereadable($XDG_CONFIG_HOME . '/vim/vimrc.after')
  source $XDG_CONFIG_HOME/vim/vimrc.after
endif
