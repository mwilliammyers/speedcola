" TODO: make this smarter?
function! s:MaybeSudoSystem(cmd, args)
  if executable(a:cmd)
    if executable('apt-get')
      call system('sudo ' . a:cmd . ' ' . a:args)
    else
      call system(a:cmd . ' ' . a:args)
    endif
  endif
endfunction


function! s:LspHook(hooktype, name)
  call s:MaybeSudoSystem('pip3', 'install python-language-server[all] pyls-mypy pyls-isort pyls-black')
  call s:MaybeSudoSystem('npm', 'i -g js-langserver typescript-language-server typescript')
  if executable('rustup')
    call system('rustup component add rls rust-analysis rust-src clippy rustfmt')
  endif
endfunction


function! PackInit() abort
  if &compatible | set nocompatible | endif

  packadd minpac

  " call minpac#init({'dir': stdpath('data') . '/site'})
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  call minpac#add('rakr/vim-one', {'type': 'opt'})

  call minpac#add('junegunn/fzf')
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('justinmk/vim-sneak')
  call minpac#add('sheerun/vim-polyglot')
  call minpac#add('simnalamburt/vim-mundo')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('vim-airline/vim-airline')
  call minpac#add('vim-airline/vim-airline-themes')
  call minpac#add('airblade/vim-gitgutter')
  call minpac#add('tpope/vim-abolish')
  call minpac#add('jeffkreeftmeijer/vim-numbertoggle')
  call minpac#add('lifepillar/vim-mucomplete')
  " call minpac#add('sgur/vim-editorconfig')
  call minpac#add('wincent/loupe')
  call minpac#add('machakann/vim-sandwich')
  call minpac#add('sbdchd/neoformat', {'do':  {-> s:MaybeSudoSystem('npm', 'i -g prettier')}})
  call minpac#add('heavenshell/vim-jsdoc')
  call minpac#add('Raimondi/yaifa')
  call minpac#add('prabirshrestha/async.vim')
  call minpac#add('prabirshrestha/vim-lsp', {'do': function('s:LspHook')})
endfunction


command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()
" HACK: used by install script so we can quit vim at the right time
command! PackBootstrap call PackInit() | call minpac#update('', {'do': 'echo "\nFinished installing all packages\n" | qall'})
