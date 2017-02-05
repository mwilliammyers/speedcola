let &t_Co=256
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set background=dark

if exists('g:cola_colorscheme')
  silent! execute "colorscheme " . g:cola_colorscheme
else
  colorscheme hybrid_material
endif
