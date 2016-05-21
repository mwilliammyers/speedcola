call plug#begin($XDG_DATA_HOME . '/nvim/site/plugged')

" Defaults {{{
  Plug 'tpope/vim-sensible'            " defaults everyone can agree on
  Plug 'editorconfig/editorconfig-vim' " consistent coding styles between different editors and IDEs
" }}}

" Navigation {{{
  Plug 'junegunn/fzf', 
        \ { 'dir': $XDG_DATA_HOME . '/fzf', 'do': './install --all' } 
        \ | Plug 'junegunn/fzf.vim'        " command-line fuzzy finder
  Plug 'scrooloose/nerdtree' 
        \ | Plug 'jistr/vim-nerdtree-tabs', 
        \ { 'on':  'NERDTreeToggle' }      " tree explorer
  " Plug 'tpope/vim-projectionist'       " project configuration
  Plug 'majutsushi/tagbar'             " display tags in a window
  Plug 'bogado/file-line'              " enable opening a file in a given line TODO: does nvim do this by default with the +option?   
  Plug 'tpope/vim-repeat'| Plug 'easymotion/vim-easymotion'
  Plug 'airblade/vim-rooter'           " changes Vim working directory to project root
        " \ { 'on': ['FindRootDirectory', 'RooterChangeToRootDirectory'] }
" }}}

" UI Additions {{{sy-to-use Vim alignment plugin
  " Colors {{{
    Plug 'flazz/vim-colorschemes'      " one colorscheme pack to rule them all
  " }}}

  Plug 'luochen1990/rainbow'           " rainbow parentheses improved
  Plug 'vim-airline/vim-airline' 
        \ | Plug 'vim-airline/vim-airline-themes'  " lean & mean status/tabline
  Plug 'kshenoy/vim-signature'         " toggle, display and navigate marks
  Plug 'mhinz/vim-signify'             " show a diff via Vim sign column
  Plug 'jszakmeister/vim-togglecursor' " toggle the cursor shape in the terminal
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'myusuf3/numbers.vim'
" }}}

" Commands {{{
  Plug 'scrooloose/nerdcommenter'      " intensely orgasmic commenting
  Plug 'tpope/vim-surround'            " quoting/parenthesizing made simple
  Plug 'tpope/vim-fugitive'            " a Git wrapper so awesome, it should be illegal
  Plug 'tpope/vim-abolish'             " search for, substitute, & abbreviate multiple variants of a word
  " Plug 'tpope/vim-eunuch'            " helpers for UNIX
  " Plug 'godlygeek/tabular'             " text filtering and alignment
  Plug 'junegunn/vim-easy-align'       " simple, easy-to-use alignment
  Plug 'benekastah/neomake'           " asynchronous :make using Neovim's job-control functionality
  Plug 'milkypostman/vim-togglelist'
  Plug 'terryma/vim-multiple-cursors'
  " Plug 'maxbrunsfeld/vim-emacs-bindings'
  Plug 'mbbill/undotree'
  Plug 'xolox/vim-misc' | Plug 'xolox/vim-session', 
        \ { 'do': 'mkdir -p $XDG_DATA_HOME/nvim/sessions' } 
" }}}

" Automatic Helpers {{{
  Plug 'SearchComplete'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-unimpaired'
  " Plug 'Townk/vim-autoclose',    { 'on': 'AutoCloseOn' }    " auto-close parentheses etc.
  " Plug 'Valloric/YouCompleteMe', { 'do': './install --all' } 
    Plug 'Shougo/deoplete.nvim'        " dark powered asynchronous completion framework
    Plug 'Shougo/context_filetype.vim' " deoplete plugin
    Plug 'Shougo/echodoc.vim'          " deoplete plugin - prints the documentation you have completed
  " snippets {{{
    Plug 'SirVer/ultisnips'            " ultimate snippet solution
    Plug 'honza/vim-snippets'          " vim-snipmate default snippets
    " Plug 'Shougo/neosnippet.vim'     " neocomplcache snippets source
    " Plug 'Shougo/neosnippet-snippets'
  " }}}
" }}}

" Text objects {{{
  Plug 'matchit.zip'                   " configure % to match more than just single characters
  " Plug 'kana/vim-textobj-user'
  " Plug 'lucapette/vim-textobj-underscore'
  " Plug 'nelstrom/vim-textobj-rubyblock', { 'for': ['ruby', 'rake'] }
" }}}

" Language specific {{{
  " C/C++ {{{
    Plug 'Shougo/neoinclude.vim', 
          \ { 'for': ['cpp', 'c'] }  " deoplete plugin - completes from canidates in included path
    " Plug 'vim-scripts/a.vim', { 'for': ['cpp', 'c'] }
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

  " ansible {{{
    " Plug 'pearofducks/ansible-vim' { 'for': ['yaml'] }
    " Plug 'chase/vim-ansible-yaml', { 'for': ['yaml'] }
    " Plug 'MicahElliott/Rocannon',  { 'for': ['yaml'] }
  " }}}

  " jinja {{{
  " TODO jinja2 syntax does not seem to be working...
    " Plug 'Glench/Vim-Jinja2-Syntax', { 'for': ['jinja'] }
    " Plug 'Glench/Vim-Jinja2-Syntax'
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
