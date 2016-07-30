" ----------------------------------------
" Platform Specific Configuration
" ----------------------------------------

set shell=bash

let g:has_powerline_font = 0

let s:uname = system("uname -s")
if s:uname =~ "Darwin"
  let g:has_powerline_font = filereadable("/Library/Fonts/Meslo LG M Regular for Powerline.otf") || filereadable($HOME."/Library/Fonts/Meslo LG M Regular for Powerline.otf")
else
  let g:has_powerline_font = filereadable($HOME."/.fonts/Meslo LG M Regular for Powerline.otf") || filereadable("/usr/local/share/fonts/Meslo LG M Regular for Powerline.otf")
endif
" FIXME: neovim does not correctly render powerline fonts in airline
if g:has_powerline_font
  set guifont=Meslo\ LG\ M\ for\ Powerline:h12
elseif has('gui_running')
  set guifont=Monaco:h12
else
  set guifont=Monospace:h12
endif
