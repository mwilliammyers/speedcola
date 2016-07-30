" Install vim-plug if it is not already installed
if empty(glob($XDG_CONFIG_HOME . '/nvim/autoload/plug.vim'))
  silent !curl -fLo $XDG_CONFIG_HOME/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin($XDG_DATA_HOME . '/nvim/site/plugged')

" Defaults {{{
  Plug 'tpope/vim-sensible'            " defaults everyone can agree on
  Plug 'editorconfig/editorconfig-vim' " consistent coding styles between different editors and IDEs
" }}}

" Navigation {{{
  Plug 'scrooloose/nerdtree'                 " a tree explorer plugin for vim
    \ | Plug 'Xuyuanp/nerdtree-git-plugin',  " a plugin of NERDTree showing git status
    \ { 'on':  'NERDTreeToggle' }     
  Plug 'bogado/file-line'                    " enable opening a file in a given line TODO: does nvim do this by default with the +option?
  Plug 'tpope/vim-repeat'| Plug 'easymotion/vim-easymotion'
  Plug 'airblade/vim-rooter'                 " changes Vim working directory to project root
  Plug 'junegunn/fzf', 
        \ { 'dir': $XDG_DATA_HOME . '/fzf', 'do': './install --bin' } 
        \ | Plug 'junegunn/fzf.vim'          " command-line fuzzy finder
" }}}

" UI Additions {{{
  " Colors {{{
    Plug 'flazz/vim-colorschemes'                 " one colorscheme pack to rule them all
  " }}}

  Plug 'luochen1990/rainbow'                      " rainbow parentheses improved
  Plug 'vim-airline/vim-airline' 
        \ | Plug 'vim-airline/vim-airline-themes' " lean & mean status/tabline
  Plug 'kshenoy/vim-signature'                    " toggle, display and navigate marks
  Plug 'mhinz/vim-signify'                        " show a diff via Vim sign column
  Plug 'jszakmeister/vim-togglecursor'            " toggle the cursor shape in the terminal
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'myusuf3/numbers.vim'
" }}}

  " Commands {{{
  Plug 'scrooloose/nerdcommenter' " intensely orgasmic commenting
  Plug 'tpope/vim-surround'       " quoting/parenthesizing made simple
  Plug 'tpope/vim-fugitive'       " a Git wrapper so awesome, it should be illegal
  Plug 'junegunn/vim-easy-align'  " simple, easy-to-use alignment
  Plug 'mbbill/undotree'          " the ultimate undo history visualizer
  Plug 'xolox/vim-misc' | Plug 'xolox/vim-session', 
        \ { 'do': 'mkdir -p $XDG_DATA_HOME/nvim/sessions' } 
  " }}}

" Automatic Helpers {{{
 " TODO better way to do this?
  function! DoRemote(arg)
    UpdateRemotePlugins
  endfunction
  Plug 'Shougo/deoplete.nvim', 
        \ { 'do': function('DoRemote') } " dark powered asynchronous completion framework
  Plug 'Shougo/context_filetype.vim'     " deoplete plugin
  Plug 'neomake/neomake'                 " asynchronous :make (provides linting)
  Plug 'tpope/vim-sleuth'                " heuristically set buffer options
  Plug 'SirVer/ultisnips'                " ultimate snippet solution
" }}}

" Language specific {{{
  " C/C++ {{{
    Plug 'Shougo/neoinclude.vim', 
          \ { 'for': ['cpp', 'c'] }   " deoplete plugin - completes from canidates in included path
  " }}}

  " Swift {{{
    Plug 'keith/swift.vim',           { 'for': ['swift'] }
    Plug 'landaire/deoplete-swift',   { 'for': ['swift'] }
  " }}}

  " Clojure {{{
    Plug 'guns/vim-clojure-static',                    { 'for': ['clojure'] }
    Plug 'tpope/vim-fireplace',                        { 'for': ['clojure'] }
    Plug 'guns/vim-sexp',                              { 'for': ['clojure'] }
    Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': ['clojure'] }
  " }}}

  " Go {{{
    Plug 'fatih/vim-go', { 'for': ['go'] }
  " }}}

  " Docker {{{
    " Plug 'honza/dockerfile.vim'       
  " }}}

  " JavaScript {{{
    Plug 'pangloss/vim-javascript',   { 'for': ['javascript']        }
    Plug 'mxw/vim-jsx',               { 'for': ['javascript']        }
    Plug 'maksimr/vim-jsbeautify',    { 'for': ['javascript']        }
    Plug 'kchmck/vim-coffee-script',  { 'for': ['coffee']            }
    Plug 'elzr/vim-json',             { 'for': ['javascript','json'] }
  " }}}

  " CSS / HTML {{{
    Plug 'mattn/emmet-vim',           { 'for': ['html','css']        }
    Plug 'tpope/vim-haml',            { 'for': ['haml']              }
    Plug 'nono/vim-handlebars',       { 'for': ['handlebars']        }
    Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss','sass']       }
    Plug 'hail2u/vim-css3-syntax',    { 'for': ['css','scss','sass'] }
    Plug 'othree/html5.vim',          { 'for': ['html']              }
    Plug 'juvenn/mustache.vim',       { 'for': ['mustache']          }
    Plug 'gregsexton/MatchTag',       { 'for': ['html','xml']        }
  " }}}

  " YAML {{{
    Plug 'ingydotnet/yaml-vim', { 'for': ['yaml'] }
  " }}}

  " Ruby {{{
    Plug 'vim-ruby/vim-ruby',           { 'for': ['ruby', 'rake'] }
    Plug 'tpope/vim-rails',             { 'for': ['ruby', 'rake'] }
    Plug 'tpope/vim-rake',              { 'for': ['ruby', 'rake'] }
    Plug 'tpope/vim-bundler',           { 'for': ['ruby', 'rake'] }
    Plug 'ecomba/vim-ruby-refactoring', { 'for': ['ruby', 'rake'] }
    Plug 'tpope/vim-cucumber',          { 'for': ['cucumber']     }
  " }}}

  " Scala {{{
    Plug 'derekwyatt/vim-scala', { 'for': ['scala'] }
  " }}}

  " PHP {{{
    Plug 'm2mdas/phpcomplete-extended', { 'for': ['php'] }  " deoplete omnifunc
  " }}}

  " TOML {{{
    Plug 'cespare/vim-toml', { 'for': ['toml'] }
  " }}}

  " Fish {{{
    Plug 'dag/vim-fish', { 'for': ['fish'] }
  " }}}

  " VimL {{{
    Plug 'ynkdir/vim-vimlparser', { 'for': 'vim' }
    Plug 'syngan/vim-vimlint',    { 'for': 'vim' }
  " }}}

  " Elixir {{{
    Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
  " }}}
" }}}

call plug#end()
