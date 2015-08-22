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

" **Files loaded in this order:**
" -`~/.vimrc`
" -`$XDG_CONFIG_HOME/vim/vimrc.local.before`
" -`~/.vim/Plug.vim`
" -`$XDG_CONFIG_HOME/vim/vimrc.local.plugins` *coming soon*
" -`~/.vim/config/*.vim`
" -`~/.vim/config/plugin/*.vim`
" -`$XDG_CONFIG_HOME/vim/vimrc.local`

" **Settings:**
" -`viminfo=n$XDG_CACHE_HOME/vim/viminfo`
" -`undodir=$XDG_CACHE_HOME/vim/undo,~/,/tmp`
" -`directory=$XDG_CACHE_HOME/vim/swap,~/,/tmp`
" -`backupdir=$XDG_CACHE_HOME/vim/backup,~/,/tmp`

if filereadable($XDG_CONFIG_HOME . '/vim/vimrc.local.before')
  source $XDG_CONFIG_HOME/vim/vimrc.local.before
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

if filereadable($XDG_CONFIG_HOME . '/vim/vimrc.local')
  source $XDG_CONFIG_HOME/vim/vimrc.local
endif
