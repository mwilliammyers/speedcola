# Vim Configuration 
[![BuildStatus](https://travis-ci.org/mkwmms/vimfiles.svg)](https://travis-ci.org/mkwmms/vimfiles)

__WIP__: checkout the key-bindings [cheat sheet](https://github.com/mkwmms/vimfiles/wiki/Cheat-Sheet).

## Installation

1. `git clone http://github.com/mkwmms/vimfiles.git ~/.vim`
1. `~/.vim/install` [more...](#install-script)
1. Enjoy

The directory contains a bash script named `install`. `install` will symlink `.vimrc` and `.gvimrc` (if you have gvim on your `$PATH`).
It will also install `golang`'s tools if you have golang on your `$PATH`.

##### Requirements

- **Requires** that you follow the [XDG base directory spec](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html) by having `$XDG_CONFIG_HOME`, `$XDG_CONFIG_HOME` and `$XDG_CONFIG_HOME` environment variables set. 
- **WIP** end goal will be to force vim into following [XDG spec](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html) à la [this](https://tlvince.com/vim-respect-xdg)

## Recommended Setup (OSX/Linux)

### Runtime configuration
**Files**
- `~/.vimrc` (WIP: move this to `$XDG_CONFIG_HOME/vim/vimrc`)
- `~/.vim` (possibly sym-linked) (WIP: move this to `$XDG_CONFIG_HOME/vim`)
- User config: `~/.vim/config/local.vim`
- `viminfo=n$XDG_CACHE_HOME/vim/viminfo`
- `undodir=$XDG_CACHE_HOME/vim/undo,~/,/tmp`
- `directory=$XDG_CACHE_HOME/vim/swap,~/,/tmp`
- `backupdir=$XDG_CACHE_HOME/vim/backup,~/,/tmp`
- Anything matching: `~/.vim/config/*.vim` will be sourced by vim

### Colors!
screenshots coming soon!

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
All plugins are managed by [vim-plug](https://github.com/junegunn/vim-plug)

See [Plug.vim](https://github.com/mkwmms/vimfiles/blob/master/Plug.vim) for a list of currently bundled plugins

#### Requirements
 * [Fugitive](https://github.com/tpope/vim-fugitive) requires Git
 * [ag.vim](https://github.com/rking/ag.vim) requires [ag](https://github.com/ggreer/the_silver_searcher)
 * [ack.vim](https://github.com/mileszs/ack.vim) requires [ack](http://betterthangrep.com/)
 * [tagbar](https://github.com/majutsushi/tagbar) requires [exuberant-ctags](https://github.com/fishman/ctags)

## Accessorize
Use `~/.vim/config/local.vim` 

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

## Notes
Be sure to always edit the vimrc using `,vi`, which opens the vimrc in the .vim folder. Vim has a nasty habit of overriding symlinks.

## Acknowledgements
- [Luan Santos' vimfiles](https://github.com/luan/vimfiles)
- [Steve Francia's legendary vim distribution](https://github.com/spf13/spf13-vim)
