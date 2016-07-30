" =======================================
" speedcola
"
" ultra fast vim configuration
" powered by vim-plug, infused with XDG and a little speed-cola
"
" Maintained By:
" William Myers @mwilliammyers [http://github.com/mwilliammyers/speedcola]
"
" Initially based on:
" Luan Santos" vimfiles [https://github.com/luan/vimfiles]
" Steve Francia"s legendary vim distribution [https://github.com/spf13/spf13-vim]
" =======================================

let g:mapleader = ","

" Load plugins
runtime! plugin.vim

" General configuration
runtime! site/*.vim

" Local configuration
runtime! local/*.vim

" Plugin configuration
runtime! plugin/*.vim
