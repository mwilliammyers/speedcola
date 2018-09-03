function! s:GutentagsHook(hooktype, name)
  if executable('apt-get')
    call system('sudo apt-get install -y universal-ctags')
  elseif executable('brew')
    call system('brew install --HEAD universal-ctags')
  endif
endfunction

function! s:LspHook(hooktype, name)
  let l:pip = 'pip3 install vim-vint isort vulture python-language-server[all]'
  let l:npm = 'npm i -g jsonlint javascript-typescript-langserver'
  if executable('apt-get')
    let l:pip = 'sudo ' . l:pip
    let l:npm = 'sudo ' . l:npm
  endif
  call system(l:pip)
  call system(l:npm)
endfunction

packadd minpac
call minpac#init({'dir': stdpath('data') . '/site'})
call minpac#add('k-takata/minpac', {'type': 'opt'})

call minpac#add('joshdick/onedark.vim', {'type': 'opt'})
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('airblade/vim-rooter')
call minpac#add('editorconfig/editorconfig-vim')
call minpac#add('ervandew/supertab')
call minpac#add('jeffkreeftmeijer/vim-numbertoggle')
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')
call minpac#add('sheerun/vim-polyglot')
call minpac#add('tpope/vim-commentary')
call minpac#add('easymotion/vim-easymotion')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-surround')
call minpac#add('simnalamburt/vim-mundo')
call minpac#add('tpope/vim-abolish')
call minpac#add('w0rp/ale', {'do': function('s:LspHook')})
call minpac#add('ludovicchabant/vim-gutentags', {'do': function('s:GutentagsHook')})
call minpac#add('natebosch/vim-lsc', {'do': function('s:LspHook')})
