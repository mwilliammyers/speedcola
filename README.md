# Vim Configuration 
[![Build Status](https://travis-ci.org/mkwmms/xdg-vimrc.svg)](https://travis-ci.org/mkwmms/xdg-vimrc)

__WIP__: checkout the key-bindings [cheat sheet](https://github.com/mkwmms/xdg-vimrc/wiki/Cheat-Sheet).

## Installation

1. `git clone http://github.com/mkwmms/xdg-vimrc.git ~/.vim`
1. `~/.vim/install`
1. Enjoy

##### How the install works

*Full disclosure:*
[the install script](https://github.com/mkwmms/xdg-vimrc/blob/master/bin/install)

*TL;DR*

1. symlink `.vimrc` 
2. symlink `.gvimrc` if you have gvim on your `$PATH`.
1. install `golang`'s tools if you have golang on your `$PATH`.


##### Requirements

- Follow the [XDG] base directory spec by having `$XDG_CONFIG_HOME`, `$XDG_CONFIG_HOME` and `$XDG_CONFIG_HOME` environment variables set. This is *WIP*; end goal will be to force vim into following the [XDG] spec à la [vim-respect-xdg]

## Recommended Setup (OSX/Linux)

### Runtime configuration
**Files loaded in this order:**
- `~/.vimrc`
- `$XDG_CONFIG_HOME/vim/vimrc.local.before`
- `~/.vim/Plug.vim`
- `$XDG_CONFIG_HOME/vim/vimrc.local.plugins` *coming soon*
- `~/.vim/config/*.vim`
- `~/.vim/config/plugin/*.vim`
- `$XDG_CONFIG_HOME/vim/vimrc.local`
**Settings:**
- `viminfo=n$XDG_CACHE_HOME/vim/viminfo`
- `undodir=$XDG_CACHE_HOME/vim/undo,~/,/tmp`
- `directory=$XDG_CACHE_HOME/vim/swap,~/,/tmp`
- `backupdir=$XDG_CACHE_HOME/vim/backup,~/,/tmp`

### Faster and better autocomplete

**OSX**

```bash
brew reinstall vim --with-lua
brew reinstall macvim --with-lua
```

**Linux**

```bash
sudo apt-get install vim-nox
```

### ctags

**OSX**

```bash
brew uninstall ctags
brew tap kopischke/ctags
brew install ctags-fishman --HEAD
```

**Linux**

*exuberant-ctags* from your OS is generally enough for most things, but if you want more CSS, ruby and other goodnesses you will need to manually compile and replace your ctags installation with: https://github.com/fishman/ctags

## Plugins
All plugins are managed by [vim-plug]

See [Plug.vim] for a list of currently bundled plugins

#### Requirements
 * [Fugitive] requires Git
 * [ag.vim] requires [ag]
 * [ack.vim] requires [ack]
 * [Tagbar] requires [exuberant-ctags]

## Accessorize
#### User config files:
- `$XDG_CONFIG_HOME/vim/vimrc.before` 
- `$XDG_CONFIG_HOME/vim/vimrc.local`
- `$XDG_CONFIG_HOME/vim/vimrc.plugins` *coming soon*

```
" will save automatically when leaving the buffer
" 0 or 1, defaults 0
let g:autosave = 1
```

To disable the neocomplete autocomplete popup:
```
let g:neocomplete#enable_at_startup = 0   " disable neocomplete
let g:neocomplcache_enable_at_startup = 0 " disable the fallback version when no LUA
```

#### Colors!
Included color schemes:
- [flazz/vim-colorschemes]
- screenshots *coming soon*

## Notes
Be sure to always edit the vimrc using `,vi`, which opens the vimrc in the .vim folder. Vim has a nasty habit of overriding symlinks.

## Intro to VIM

Here's some tips if you've never used VIM before:

#### Tutorials

* Type `vimtutor` into a shell to go through a brief interactive
  tutorial inside VIM.
* Read the slides at [VIM: Walking Without Crutches](https://walking-without-crutches.heroku.com/#1).

#### Modes

* VIM has two (common) modes:
  * insert mode- stuff you type is added to the buffer
  * normal mode- keys you hit are interpreted as commands
* To enter insert mode, hit `i`
* To exit insert mode, hit `<ESC>`

#### Useful commands

* Use `:q` to exit vim
* Certain commands are prefixed with a `<Leader>` key, which by default maps to `\` xdg-vim uses `let mapleader = ","` to change this to `,` which is in a consistent and convenient location.
* [keyboard cheat sheet](https://walking-without-crutches.heroku.com/image/images/vi-vim-cheat-sheet.png).

## Acknowledgements
- Luan Santos'  [vimfiles]
- [spf13-vim] legendary vim distribution

[Git]:http://git-scm.com
[Curl]:http://curl.haxx.se
[Vim]:http://www.vim.org/download.php#pc
[MacVim]:http://code.google.com/p/macvim/

[vim-respect-xdg]:https://tlvince.com/vim-respect-xdg
[XDG]:http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html

[vim-plug]:https://github.com/junegunn/vim-plug
[Plug.vim]:https://github.com/mkwmms/vimfiles/blob/master/Plug.vim

[ack]:http://betterthangrep.com/
[ag]:https://github.com/ggreer/the_silver_searcher
[exuberant-ctags]:https://github.com/fishman/ctags

[Vundle]:https://github.com/gmarik/vundle
[PIV]:https://github.com/spf13/PIV
[NERDCommenter]:https://github.com/scrooloose/nerdcommenter
[Undotree]:https://github.com/mbbill/undotree
[NERDTree]:https://github.com/scrooloose/nerdtree
[ctrlp]:https://github.com/kien/ctrlp.vim
[solarized]:https://github.com/altercation/vim-colors-solarized
[neocomplete]:https://github.com/shougo/neocomplete
[Fugitive]:https://github.com/tpope/vim-fugitive
[Surround]:https://github.com/tpope/vim-surround
[Tagbar]:https://github.com/majutsushi/tagbar
[Syntastic]:https://github.com/scrooloose/syntastic
[vim-easymotion]:https://github.com/Lokaltog/vim-easymotion
[YouCompleteMe]:https://github.com/Valloric/YouCompleteMe
[Matchit]:http://www.vim.org/scripts/script.php?script_id=39
[Tabularize]:https://github.com/godlygeek/tabular
[EasyMotion]:https://github.com/Lokaltog/vim-easymotion
[Airline]:https://github.com/bling/vim-airline
[Powerline]:https://github.com/lokaltog/powerline
[Powerline Fonts]:https://github.com/Lokaltog/powerline-fonts
[AutoClose]:https://github.com/spf13/vim-autoclose
[ag.vim]:https://github.com/rking/ag.vim
[Ack.vim]:https://github.com/mileszs/ack.vim

[flazz/vim-colorschemes]:https://github.com/flazz/vim-colorschemes/tree/master/colors

[spf13-vim]:https://github.com/spf13/spf13-vim
[vimfiles]:https://github.com/luan/vimfiles

[spf13-vim-img]:https://i.imgur.com/UKToY.png
[spf13-vimrc-img]:https://i.imgur.com/kZWj1.png
[autocomplete-img]:https://i.imgur.com/90Gg7.png
[tagbar-img]:https://i.imgur.com/cjbrC.png
[fugitive-img]:https://i.imgur.com/4NrxV.png
[nerdtree-img]:https://i.imgur.com/9xIfu.png
[phpmanual-img]:https://i.imgur.com/c0GGP.png
[easymotion-img]:https://i.imgur.com/ZsrVL.png
[airline-img]:https://i.imgur.com/D4ZYADr.png
