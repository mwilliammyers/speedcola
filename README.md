#speed-cola [![Build Status](https://travis-ci.org/mkwmms/speed-cola.svg?branch=master)](https://travis-ci.org/mkwmms/speed-cola)

#### Ultra fast vim configuration; powered by vim-plug, infused with XDG and a little speed-cola

"Just take a sip, you will move faster. Just try it now! And speed is mastered!
Press those lips against the only one that really moves you.
Speed Cola speeds up your life!"

__WIP__: checkout the key-bindings [cheat sheet](https://github.com/mkwmms/xdg-vimrc/wiki/Cheat-Sheet).
For a complete list of keybindings type `:map` inside Vim

## Installation
bash, zsh etc. (bash-compatible shell):

`bash <(curl https://j.mp/go-speed-cola -L)`

fish:

`curl https://j.mp/go-speed-cola -L > speed-cola.sh; and sh speed-cola.sh;
and rm speed-cola.sh`

#### How the install works

*Full disclosure:*
[the install script](https://github.com/mkwmms/speed-cola/blob/master/cola)

*TL;DR*

1. Backup your existing vim configuration
1. Symlink `~/.vim/config/vimrc` to `~/.vimrc`
1. Install `golang`'s tools if you have golang on your `$PATH`
unless `$COLA_GOLANG_DEPS=false`.
1. Install all of your plugins and their dependencies

#### Update early and often!
pretty much the same as the install except that it
won't backup your configuration and it will go straight to updating your plugins

**How?**

take your pick:

- `$XDG_CONFIG_HOME/vim/cola`
- do a regular [install](https://github.com/mkwmms/speed-cola#installation)


#### Requirements
- Linux, *nix, or OS X
- Git 1.7+
- Vim 7.3+
- Use the [XDG] base directory spec by having `$XDG_CONFIG_HOME`, `$XDG_CONFIG_HOME` and `$XDG_CONFIG_HOME` environment variables set. This is *WIP*;
end goal will be to force vim into following the [XDG] spec à la [vim-respect-xdg]

## The Setup

### Runtime configuration
**Files loaded in this order:**
- `~/.vimrc` -> `$XDG_CONFIG_HOME/vim/vimrc` (just controls the load order and vim runtime)
- `$XDG_CONFIG_HOME/vim/config/local/vimrc`
- `$XDG_CONFIG_HOME/vim/local/config/Plug.vim`
- `$XDG_CONFIG_HOME/vim/config/Plug.vim`
- `$XDG_CONFIG_HOME/vim/local/config/*.vim`
- `$XDG_CONFIG_HOME/vim/config/*.vim`
- `$XDG_CONFIG_HOME/vim/local/config/plugin/*.vim`
- `$XDG_CONFIG_HOME/vim/config/plugin/*.vim`

**Directories/settings:**
- Plugins are downloaded to: `$XDG_DATA_HOME/vim/plugged`
- <plugin name> cache directory: `$XDG_CACHE_HOME/vim/<plugin name>`
- Session directory: `$VIM_DATA_HOME/sessions`
- `undodir=$XDG_CACHE_HOME/vim/undo,~/,/tmp`
- `directory=$XDG_CACHE_HOME/vim/swap,~/,/tmp`
- `backupdir=$XDG_CACHE_HOME/vim/backup,~/,/tmp`
- `viminfo=n$XDG_CACHE_HOME/vim/viminfo`

### Recommended setup

#### Faster and better autocomplete

**OSX**

```bash
brew reinstall vim --with-lua
brew reinstall macvim --with-lua
```

**Linux**

```bash
sudo apt-get install vim-nox
```

#### ctags

**OSX**

```bash
brew uninstall ctags
brew tap kopischke/ctags
brew install ctags-fishman --HEAD
```

**Linux**

*exuberant-ctags* from your OS is generally enough for most things, but if you want more CSS, ruby and other goodnesses you will need to manually compile and replace your ctags installation with: https://github.com/fishman/ctags

## Plugins

**All plugins are managed by [vim-plug]**

See [Plug.vim] for a list of currently bundled plugins

### Requirements
 * [Fugitive] requires Git
 * [ag.vim] requires [ag]
 * [ack.vim] requires [ack]
 * [Tagbar] requires [exuberant-ctags]

### Meet the plugins

#### [Undotree]

If you undo changes and then make a new change, in most editors the changes you undid are gone forever, as their undo-history is a simple list.
Since version 7.0 vim uses an undo-tree instead. If you make a new change after undoing changes, a new branch is created in that tree.
Combined with persistent undo, this is nearly as flexible and safe as git ;-)

Undotree makes that feature more accessible by creating a visual representation of said undo-tree.

**QuickStart** Launch using `<Leader>u`

#### [NERDTree]

NERDTree is a file explorer plugin that provides "project drawer"
functionality to your vim editing.  You can learn more about it with
`:help NERDTree`.

**QuickStart** Launch using `\`

#### [ctrlp]
Ctrlp provides an intuitive and fast mechanism to load files from the file system (with regex and fuzzy find), from open buffers, and from recently used files.

**QuickStart** Launch using `<c-p>`.

#### [Surround]

This plugin is a tool for dealing with pairs of "surroundings."  Examples
of surroundings include parentheses, quotes, and HTML tags.  They are
closely related to what Vim refers to as text-objects.  Provided
are mappings to allow for removing, changing, and adding surroundings.

Details follow on the exact semantics, but first, consider the following
examples.  An asterisk (*) is used to denote the cursor position.

      Old text                  Command     New text ~
      "Hello *world!"           ds"         Hello world!
      [123+4*56]/2              cs])        (123+456)/2
      "Look ma, I'm *HTML!"     cs"<q>      <q>Look ma, I'm HTML!</q>
      if *x>3 {                 ysW(        if ( x>3 ) {
      my $str = *whee!;         vllllS'     my $str = 'whee!';

For instance, if the cursor was inside `"foo bar"`, you could type
`cs"'` to convert the text to `'foo bar'`.

There's a lot more, check it out at `:help surround`

#### [neocomplete]

Neocomplete is an amazing autocomplete plugin with additional support for snippets. It can complete simulatiously from the dictionary, buffer, omnicomplete and snippets. This is the one true plugin that brings Vim autocomplete on par with the best editors.

**QuickStart** Just start typing, it will autocomplete where possible

#### [Syntastic]

Syntastic is a syntax checking plugin that runs buffers through external syntax
checkers as they are saved and opened. If syntax errors are detected, the user
is notified and is happy because they didn't have to compile their code or
execute their script to find them.

#### [AutoClose]

AutoClose does what you expect. It's simple, if you open a bracket, paren, brace, quote,
etc, it automatically closes it. It handles curlys correctly and doesn't get in the
way of double curlies for things like jinja and twig.

## Accessorize
### User config files:
- mimics the directory structure of speed-cola (`$XDG_CONFIG_HOME/vim`)
- loaded in this order:
      - `$XDG_CONFIG_HOME/vim/local/vimrc` (override default settings from speed-cola)
      - `$XDG_CONFIG_HOME/vim/local/config/*.vim` (misc/general configuration)
      - `$XDG_CONFIG_HOME/vim/local/Plug.vim` (load non-default plugins)
      - `$XDG_CONFIG_HOME/vim/local/config/plugin/*.vim` (configure non-default plugins)

Put this in `$XDG_CONFIG_HOME/vim/config/local/vimrc` to disable the neocomplete autocomplete popup:
```
let g:neocomplete#enable_at_startup = 0   " disable neocomplete
let g:neocomplcache_enable_at_startup = 0 " disable the fallback version when no LUA
```

*more coming soon*

### Colors!
- Default color scheme: `Tomorrow-Night`
- Use a different color scheme:
  - `echo "let g:cola_colorscheme='solarized'" >> "$XDG_CONFIG_HOME/vim/config/local/vimrc"`
- List of available color schemes: [flazz/vim-colorschemes]
- screenshots *coming soon*

## Intro to VIM

Here's some tips if you've never used VIM before:

### Tutorials

- Type `vimtutor` into a shell to go through a brief interactive
  tutorial inside VIM.
- Read the slides at [VIM: Walking Without Crutches](https://walking-without-crutches.heroku.com/#1).
- [keyboard cheat sheet](https://walking-without-crutches.heroku.com/image/images/vi-vim-cheat-sheet.png).

### Modes

- VIM has two (common) modes:
  - insert mode- stuff you type is added to the buffer
  - normal mode- keys you hit are interpreted as commands
- To enter insert mode, hit `i`
- To exit insert mode, hit `<ESC>`

### Useful commands

- Use `:q` to exit vim
- Certain commands are prefixed with a `<Leader>` key, which by default maps to `\` we use `let mapleader = ","` to change this to `,` which is in a consistent and convenient location.

## Acknowledgements
- [spf13-vim] legendary vim distribution
- Luan Santos' [vimfiles]

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
