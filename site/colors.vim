let &t_Co=256

set background=dark

if exists('g:cola_colorscheme')
  silent! execute "colorscheme " . g:cola_colorscheme
else
  colorscheme hybrid_material
endif
