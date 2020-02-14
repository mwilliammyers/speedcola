function! s:InstallPkg(slug, ...)
  let l:split_slug = split(a:slug, '/')
  let l:pkg_dir = get(a:, 1, 'minpac')
  let l:pkg_type = get(a:, 2, 'opt')

  let l:dir = join([split(&packpath, ',')[0], 'pack', l:pkg_dir, l:pkg_type, l:split_slug[1]], '/')
  if !isdirectory(l:dir)
    return system('git clone --depth=1 https://github.com/' . a:slug . '.git ' . l:dir)
  " else
  "   return system('git -C ' . l:dir . ' pull --autostash --ff-only --depth=1')
  endif
endfunction


function! s:LspHook(hooktype, name)
  call syspkg#pip3_install('python-language-server[all]', 'pyls-mypy', 'pyls-isort', 'pyls-black')
  call syspkg#npm_install('js-langserver', 'typescript-language-server', 'typescript')
  if executable('rustup')
    call system('rustup component add rls rust-analysis rust-src clippy rustfmt')
  endif
endfunction


function! PackInit() abort
  if &compatible | set nocompatible | endif

  call s:InstallPkg('k-takata/minpac')
  call s:InstallPkg('mwilliammyers/syspkg')

  packadd minpac
  packadd syspkg 

  call minpac#init()

  call minpac#add('k-takata/minpac', {'type': 'opt'})
  call minpac#add('mwilliammyers/syspkg', {'type': 'opt'})

  call minpac#add('rakr/vim-one', {'type': 'opt'})

  call minpac#add('Raimondi/yaifa')
  call minpac#add('airblade/vim-gitgutter')
  call minpac#add('heavenshell/vim-jsdoc', {'type': 'opt'})
  call minpac#add('iamcco/markdown-preview.nvim', {'do': {-> system('cd app && ./install.sh')}})
  call minpac#add('jeffkreeftmeijer/vim-numbertoggle')
  call minpac#add('junegunn/fzf', {'do': {-> syspkg#install('ripgrep')}})
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('justinmk/vim-sneak')
  call minpac#add('lifepillar/vim-mucomplete')
  call minpac#add('liuchengxu/vista.vim')
  call minpac#add('ludovicchabant/vim-gutentags')
  call minpac#add('machakann/vim-sandwich')
  call minpac#add('neovim/nvim-lsp', {'type': 'opt', 'do': function('s:LspHook')})
  call minpac#add('sbdchd/neoformat', {'do':  {-> syspkg#npm_install('prettier')}})
  call minpac#add('sgur/vim-editorconfig')
  call minpac#add('sheerun/vim-polyglot')
  call minpac#add('simnalamburt/vim-mundo')
  call minpac#add('tpope/vim-abolish')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('vim-airline/vim-airline')
  call minpac#add('vim-airline/vim-airline-themes')
  call minpac#add('wincent/loupe')
endfunction


command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()
" HACK: used by install script so we can quit vim at the right time
command! PackBootstrap call PackInit() | call minpac#update('', {'do': 'echo "\nFinished installing all packages\n" | qall'})
