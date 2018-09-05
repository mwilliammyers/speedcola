function! s:GetPackageNames(packager, names)
  let l:apps = a:names
  if type(l:apps) is v:t_dict
     let l:apps = get(l:apps, a:packager, get(l:apps, '*', []))
  endif

  if type(l:apps) is v:t_list
    return ' ' . join(l:apps, ' ')
  elseif type(l:apps) is v:t_string
    return ' ' . l:apps . ' '
  else
    return ' '
  endif
endfunction

function! s:SystemPackage(names, ...)
  let l:opts = get(a:, 1, {})

  if executable('apt-get')
    let l:apps = s:GetPackageNames('apt-get', a:names)
    let l:apt_opts = get(l:opts, 'apt-get', '')
    call system('sudo apt-get install -y ' . l:apt_opts . l:apps)
  elseif executable('brew')
    let l:apps = s:GetPackageNames('brew', a:names)
    call system('brew install ' . get(l:opts, 'brew', '') . l:apps)
  endif
endfunction

function! s:LspHook(hooktype, name)
  let l:pip = 'pip3 install python-language-server[all] pyls-mypy pyls-isort'
  let l:npm = 'npm i -g javascript-typescript-langserver'
  if executable('apt-get')
    let l:pip = 'sudo ' . l:pip
    let l:npm = 'sudo ' . l:npm
  endif
  if executable('pip3') | call jobstart([l:pip]) | endif
  if executable('npm') | call jobstart([l:npm]) | endif

  if executable('rustup')
      call system(l:rustup . ' component add rls-preview rust-analysis rust-src')
  endif
  
  # TODO: requires `make` and a rust toolchain if pre-built binary does not exist
  call system('bash install.sh')
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
call minpac#add('prettier/vim-prettier', {'do': jobstart("npm i -g prettier")})
call minpac#add('ludovicchabant/vim-gutentags',
                \ {'do': s:SystemPackage('universal-ctags', {'brew': '--HEAD'})})
call minpac#add('autozimu/LanguageClient-neovim',
                \ {'do': function('s:LspHook'), 'branch': 'next'})
