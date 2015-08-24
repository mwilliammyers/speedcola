let &t_Co=256

function! colors#toggle_background()
  if &background == 'light'
    set background=dark
  else
    set background=light
  endif
endfunction

command! ColorsToggleBG call colors#toggle_background()
map <silent><F4> :ColorsToggleBG<cr>

set background=dark

if exists('g:color_scheme')
  silent! execute "colorscheme " . g:color_scheme
else
  " syntax enable
  " set background=dark
  " colorscheme solarized
  let g:hybrid_use_Xresources = 1
  colorscheme hybrid 
endif
