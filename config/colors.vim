let &t_Co=256

set background=dark

if exists('g:cola_colorscheme')
  silent! execute "colorscheme " . g:cola_colorscheme
else
  let g:hybrid_use_Xresources = 1
  colorscheme hybrid 
endif
